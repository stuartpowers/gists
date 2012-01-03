#!/bin/bash

# one-off script to process incoming files
# Stuart Powers http://sente.cc/
# stuart.powers@gmail.com


shopt -s nullglob

for f in /home/discuss-xfer/*.zip; do

    #clear the unzip directory and then unzip the new files into it
    #unzip the files to discus_unzip

    echo "unzipping $f" >> /di/compet/logs/discus.log
    rm -f discus_unzip/
    unzip -o -d discus_unzip/ "$f"

    ls -lrt discus_unzip >> /di/compet/logs/discus.log

    mv -f discus_unzip/DISCUS_*_Brand.txt      /di/compet/incoming_discus/DISCUS_Brand.txt  2>/dev/null
    mv -f discus_unzip/DISCUS_NACOMM.txt       /di/compet/incoming_discus/DISCUS_NACOMM.txt 2>/dev/null
    mv -f discus_unzip/DISCUS*Transaction*.txt /di/compet/incoming_discus/DISCUS_Shipment_Transaction.txt 2>/dev/null

    ls -lrt /di/compet/incoming_discus/ >> /di/compet/logs/discus.log

    #move the zip file to the done directory
    mv -f "$f" /xfers/done/discus/

done
