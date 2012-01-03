#!/bin/bash

# one-off script to process incoming files
# Stuart Powers http://sente.cc/
# stuart.powers@gmail.com


LOGDIR=/home/spowers/td-download/logs

function mv {
   echo mv "$@" >> ${LOGDIR}/${customer}.log
   command mv "$@"
}

function unzip {
   echo unzip "$@" >> ${LOGDIR}/${customer}.log
   command unzip "$@"
}


cd "$1" || exit 1

test -f download.sh || exit 1
test -f download.ftp || exit 1

customer="$(basename "$1")"

echo $customer

date >> ${LOGDIR}/${customer}.log

bash download.sh


shopt -s nullglob # so if there are no .ZIP/zip files, do nothing
                  # otherwise the loop will be called with $f = "*.ZIP"


for f in *.{ZIP,zip}; do

   [[ -d tmp ]] && rm -rf tmp
   unzip -d tmp $f; 

   for file in tmp/*; do
      timestamp=$(date -r "$file" +%F)
      mkdir -p zips/$timestamp
      mv "$file" zips/$timestamp      
   done

   mv "$f" zips/$timestamp

done