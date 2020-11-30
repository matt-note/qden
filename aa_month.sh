#!/bin/bash

# 開始日付と実行時日付を設定
START_YM=2011-08-01
END_YM=`date +%Y-%m-%d`

TEMP_YM=$START_YM
while [ 1 ] ; do

  # yyyymmを比較して、END_YM分まで処理したら終わり。それまで月を1加算していく。
  if [ ${TEMP_YM:0:7} = ${END_YM:0:7} ] ; then
    break
  fi

  # 月を1加算
  TEMP_YM=`date -d "$TEMP_YM 1 month" "+%Y-%m-%d"`

  echo "*** "$TEMP_YM" ***"

  # 一旦、ファイル作成を確認
  # 欲しい期間のデータを取得できるか確認
  curl -G \
    --data-urlencode "query=created:>$TEMP_YM created:<$(date -d "$TEMP_YM 1 month" "+%Y-%m") stocks:>262" \
    --data-urlencode "page=1" \
    --data-urlencode "per_page=100" \
    --silent \
  -H 'Authorization: Bearer '$QIITA_TOKEN 'https://qiita.com/api/v2/items' | \
  jq '. | map({ title: .title?, url: .url?, likes_count: .likes_count?, created_at: .created_at?, updated_at: .updated_at?, id: .user.id?}) | sort_by(.likes_count) | reverse' > data/${TEMP_YM:0:7}.json

done
