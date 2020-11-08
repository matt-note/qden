#!/bin/bash

# MacでGNUのdateコマンドを使うには、gdateコマンドとなる。もどかしい。。
START_YM=20200816
END_YM=`date +%Y%m%d`

TEMP_YM=$START_YM
while [ 1 ] ; do

  # yyyymmを比較して、END_YM分まで処理したら終わり。それまで月を1加算していく。
  if [ ${TEMP_YM:0:6} = ${END_YM:0:6} ] ; then
    break
  fi

  # 一旦、ファイル作成を確認
  echo "hoge" > data/${TEMP_YM:0:4}-${TEMP_YM:5:6}.json

  # 日付をインクリメント
  TEMP_YM=`date -d "$TEMP_YM 1 month" "+%Y%m%d"`
done
