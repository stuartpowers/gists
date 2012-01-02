#!/bin/sh
#Stuart Powers

#example function of how to sort input by date (as determined by stat %Y) 

function sort-by-date ()
{
    for f in $@;
    do
        echo -ne "$f ";
        stat -c %Y "$f";
    done | sort -k2 | cut -f1 -d' '
}
