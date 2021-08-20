#!/bin/bash

set -- "${1:-$(</dev/stdin)}" "${@:2}"
BASE="docker.sparta.corp.magento.com:5000/m2"

for tag in $@
do
    echo -e "$tag"
    v=$( [[ $tag =~ ^([^-]*-p[0-9]) ]] && echo " --version ${BASH_REMATCH[1]} " || echo "" )
    echo -e "$v"
    e=$( [[ $tag =~ "-ce" ]] && echo "" || echo " --ee-path magento2ee " )
    s=$( [[ $tag =~ "-git" ]] && echo " --source git " || echo " --source composer " )
    sd=$( [[ $tag =~ "-sd" ]] && echo " --sample-data yes " || echo " --sample-data no " )
    b2b=$( [[ $tag =~ "-b2b" ]] && echo " --b2b " || echo "" )
    docker stop $tag
    docker rm $tag
    docker run -d -v ~/.ssh/:/home/apache/.ssh/ -v ~/.composer:/home/apache/.composer --name $tag $BASE:base
    docker exec $tag sudo -u apache /bin/bash -c "echo -e \"MAGENTO_EE_PATH=\\n\" >> ~/.m2install.conf && cd /var/www/html && m2install.sh $e$v$s$sd$b2b --force && chmod -R 777 ./var ./pub/media ./pub/static ./app/etc && curl http://web2.sparta.corp.magento.com/dev/support/tools/configuration/m2configuration | n98-magerun2 script"
    docker stop $tag
    docker commit $tag $BASE:$tag
    docker push $BASE:$tag
    docker rm $tag
    docker rmi $BASE:$tag
done
