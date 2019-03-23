#!/bin/bash

FTPUSER=backup112515
FTPPASSWORD=Zb6u8fbWAjK29k3K
FTPHOST="ftp://backupovz1.fastvps.ru"
FTPHOSTC="ftp://backupovz1.fastvps.ru/"
DIRFILE="dir.txt"

echo 0 > size.txt
curl  $FTPHOST --user $FTPUSER:$FTPPASSWORD | grep ^-......... | awk -F " " '{print $5}' >> size.txt
curl  $FTPHOST --user $FTPUSER:$FTPPASSWORD | grep ^d......... | awk -F " " '{print $9}' > dir.txt
for CARDIR in $(cat $DIRFILE)
do 
curl  $FTPHOSTC$CARDIR/ --user $FTPUSER:$FTPPASSWORD | grep ^-......... | awk -F " " '{print $5}' >> size.txt
NEWDIR=$(curl  $FTPHOSTC$CARDIR/ --user $FTPUSER:$FTPPASSWORD | grep ^d......... | awk -F " " '{print $9}')
echo $NEWDIR >> dir.txt
done

BSIZE=$(paste -sd+ size.txt | bc)
GSIZE=`echo "${BSIZE}/1073741824" | bc -l`
#GSIZE=$($BSIZE/1073741824)

echo $BSIZE Bytes
echo $GSIZE GBytes


