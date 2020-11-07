#!/bin/bash

# MacでGNUのdateコマンドを使うには、gdateコマンドとなる。もどかしい。。
START_YM=20200616
END_YM=`date +%Y%m%d`

# 新規ファイルは >>で作成できるので、過去のファイルは削除。
rm month.csv

TEMP_YM=$START_YM
while [ 1 ] ; do

  # END_YM分まで処理したら終わり
  if [ ${TEMP_YM:0:6} = ${END_YM:0:6} ] ; then
    break
  fi

  # 日付をファイルに書き込み
  # > だけだと無限ループになる。
  echo `date -d "$TEMP_YM 1 month" "+%Y-%m"` >> month.csv

  # 日付をインクリメント
  TEMP_YM=`date -d "$TEMP_YM 1 month" "+%Y%m%d"`
done
