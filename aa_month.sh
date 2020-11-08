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
  curl -G \
    --data-urlencode "query=created:>2020-10-01 created:<2020-11 stocks:>262" \
    --data-urlencode "page=1" \
    --data-urlencode "per_page=100" \
  -H 'Authorization: Bearer c32dd88c4bdff501c8ab63f2b72b7b7547a1a44b' 'https://qiita.com/api/v2/items' | \
  jq '. | map({ title: .title?, url: .url?, likes_count: .likes_count?, created_at: .created_at?, updated_at: .updated_at?, id: .user.id?}) | sort_by(.likes_count) | reverse' > data/${TEMP_YM:0:7}.json

  # 月を1加算
  TEMP_YM=`date -d "$TEMP_YM 1 month" "+%Y-%m-%d"`
done
