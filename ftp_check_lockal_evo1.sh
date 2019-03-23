#!/bin/bash

FTPUSER=ftp_u
FTPPASSWORD=centos
FTPHOST="ftp://192.168.0.112"
FTPHOSTC="ftp://192.168.0.112/"
DIRFILE="dir.txt"
touch dir.txt
echo 0 > size.txt
curl  $FTPHOST --user $FTPUSER:$FTPPASSWORD | grep ^-......... | awk -F " " '{print $5}' >> size.txt
curl  $FTPHOST --user $FTPUSER:$FTPPASSWORD | grep ^d......... | awk -F " " '{print $9}' > dir.txt
for T_M_P  in $(cat $DIRFILE)
do
for CARDIR in $(cat $DIRFILE)
do 
curl  $FTPHOSTC$CARDIR/ --user $FTPUSER:$FTPPASSWORD | grep ^-......... | awk -F " " '{print $5}' >> size.txt
curl  $FTPHOSTC$CARDIR/ --user $FTPUSER:$FTPPASSWORD | grep ^d......... | awk -F " " '{print $9}' > dir.temp.txt
for NEWDIR in $(cat dir.temp.txt)
do
echo $CARDIR" "$NEWDIR

echo -e $CARDIR"/"$NEWDIR >> dir.txt
done
done
done

BSIZE=$(paste -sd+ size.txt | bc -l)
GSIZE=`echo "${BSIZE}/1073741824" | bc -l`
#GSIZE=$($BSIZE/1073741824)

echo $BSIZE Bytes
echo $GSIZE GBytes


