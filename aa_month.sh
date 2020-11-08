#!/bin/bash

# MacでGNUのdateコマンドを使うには、gdateコマンドとなる。もどかしい。。
START_YM=2020-09-16
END_YM=`date +%Y-%m-%d`

TEMP_YM=$START_YM
while [ 1 ] ; do

  # yyyymmを比較して、END_YM分まで処理したら終わり。それまで月を1加算していく。
  if [ ${TEMP_YM:0:7} = ${END_YM:0:7} ] ; then
    break
  fi

  # 一旦、ファイル作成を確認
  echo "hoge" > data/${TEMP_YM:0:7}.json

  # 日付をインクリメント 20201108
  TEMP_YM=`date -d "$TEMP_YM 1 month" "+%Y-%m-%d"`
done
