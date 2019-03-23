#!/bin/bash

FTPUSER=ftp_u
FTPPASSWORD=centos
FTPHOST="ftp://192.168.0.112"
FTPHOSTC="ftp://192.168.0.112/"
DIRFILE="dir.txt"

echo 0 > size.txt
curl  $FTPHOST --user $FTPUSER:$FTPPASSWORD | grep ^-......... | awk -F " " '{print $5}' >> size.txt
curl  $FTPHOST --user $FTPUSER:$FTPPASSWORD | grep ^d......... | awk -F " " '{print $9}' > dir.txt
for CARDIR in $(cat $DIRFILE)
do 
curl  $FTPHOSTC$CARDIR/ --user $FTPUSER:$FTPPASSWORD | grep ^-......... | awk -F " " '{print $5}' >> size.txt
NEWDIR=$CARDIR/$(curl  $FTPHOSTC$CARDIR/ --user $FTPUSER:$FTPPASSWORD | grep ^d......... | awk -F " " '{print $9}')
echo $NEWDIR"/"
echo -en $NEWDIR"/" >> dir.txt
done

BSIZE=$(paste -sd+ size.txt | bc)
GSIZE=`echo "${BSIZE}/1073741824" | bc`
#GSIZE=$($BSIZE/1073741824)

echo $BSIZE Bytes
echo $GSIZE GBytes


