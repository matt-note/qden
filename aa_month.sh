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

  # 月を1加算して月末の日付となるように設定
  TEMP_YM=`date -d "$TEMP_YM + 1 month - 1 days" "+%Y-%m-%d"`
  # TEMP_YM=`date -d "$TEMP_YM + 1 month" "+%Y-%m-%d"` # いったん、うまく行った時のやつで動かす
  echo "*** 月初: "$TEMP_YM" ***"

  # データ取得。Qiitaは「以上」の検索ができないっぽい。
  curl -G \
    # --data-urlencode "created:>$TEMP_YM created:<$(date -d "$TEMP_YM 1 month" "+%Y-%m") stocks:>261" \
    --data-urlencode "query=created:>$TEMP_YM created:<$(date -d "$TEMP_YM 1 month" "+%Y-%m") stocks:>261"
    --data-urlencode "page=1" \
    --data-urlencode "per_page=100" \
    --silent \
  -H 'Authorization: Bearer '$QIITA_TOKEN 'https://qiita.com/api/v2/items' | \
  jq '. | map({ title: .title?, url: .url?, likes_count: .likes_count?, created_at: .created_at?, updated_at: .updated_at?, id: .user.id?}) | sort_by(.likes_count) | reverse' > data/$(date -d "$TEMP_YM" "+%Y-%m").json

  # 月初に戻しておく。
  TEMP_YM=`date -d "$TEMP_YM + 1 days" "+%Y-%m-%d"`

  echo "*** 月末: "$TEMP_YM" ***"
done
