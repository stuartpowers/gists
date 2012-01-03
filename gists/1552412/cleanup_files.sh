#!/bin/bash
# This creates a somewhat "interactive prompt" I used to deal
# with $HOME/ clutter... it's quick and dirty.
# Stuart Powers http://sente.cc/
# stuart.powers@gmail.com

function action(){
    line="$1"
    read -p "prompt.." < /dev/tty;
    if [[ $REPLY = "rm" ]]; then
        mv "$line" rm/;
    fi;
    if [[ $REPLY = "quit" ]]; then
        break;
    fi;
    if [[ $REPLY = "safe" ]]; then
        mv "$line" safe/
        return
    fi;
    if [[ $REPLY = "command" ]]; then
        read -p "command?" < /dev/tty
        $REPLY "$line"
        return
    fi;
    if [[ $REPLY = "vim" ]]; then
        echo "" | vim - -c "edit! $line";
        return
    fi;

}

    for line in "$@";
    do
        file $line;
        ls -lrt *.txt | grep -w -C3 "$line$"
        wc "$line";
        head -n30 "$line" | nl | expand | cut -c1-${COLUMNS};
        tail -n10 "$line" | nl | expand | cut -c1-${COLUMNS};
        action "$line"
    done
