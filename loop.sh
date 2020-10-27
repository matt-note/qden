#!/bin/bash

START_DATE=20170928
END_DATE=20171010
current=$START_DATE
while [ "$current" != "$END_DATE" ]
do
    current=`date -j -v+1d -f %Y%m%d $current +%Y%m%d`
    echo $current
done
