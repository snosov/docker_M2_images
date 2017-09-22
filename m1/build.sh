#!/bin/bash

set -- "${1:-$(</dev/stdin)}" "${@:2}"
BASE="docker.sparta.corp.magento.com:5000/m1"

for tag in $@
do
    echo -e "$tag"
    docker stop $tag
    docker rm $tag
    docker run -d -v ~/.ssh/:/home/apache/.ssh/ -v ~/.composer:/home/apache/.composer --name $tag $BASE:base
    docker exec $tag sudo -u apache /bin/bash -c "cd /var/www/html/ && /usr/local/bin/m1install.sh v$tag clone"
    docker stop $tag
    docker commit $tag $BASE:$tag
    docker push $BASE:$tag
    docker rm $tag
    docker rmi $BASE:$tag
done
