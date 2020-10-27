#!/bin/bash
START_DATE="20140101"
END_DATE="20140403"

for (( DATE=${START_DATE} ; ${DATE} < ${END_DATE} ; DATE=`date -d "${DATE} 1 day" '+%Y%m%d'` )) ; do
  echo ${DATE}
done
