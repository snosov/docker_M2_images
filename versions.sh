#!/bin/bash
#for v in 2.2.0 2.2.1 2.2.2 2.2.3 2.2.4 2.2.5 2.2.6 2.2.7 2.3.0 2.3.1
for v in 2.3.7 2.4.2-p1
do
    for e in ee #ce
    do
        for s in composer git
        do
            for sd in no yes
            do
                for b2b in no yes
                do
                    ev=$([[ $e == "ce" ]] && echo "-ce" || echo "" )
                    sv=$([[ $s == "git" ]] && echo "-git" || echo "" )
                    sdv=$([[ $sd == "yes" ]] && echo "-sd" || echo "" )
                    b2bv=$([[ $b2b == "yes" ]] && echo "-b2b" || echo "" )
                    echo "$v$ev$sv$sdv$b2bv"
                done
            done
        done
    done
done
