#!/bin/bash
for v in 2.0.9 2.0.10 2.0.11 2.0.12 2.0.13 2.0.14 2.0.15 2.0.16 2.1.0 2.1.1 2.1.2 2.1.3 2.1.4 2.1.5 2.1.6 2.1.7 2.1.8 2.1.9
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
