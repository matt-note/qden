
## 事前準備
input.jsonにデータを準備する。

```input.json

```


## qiita
Qiita APIで取得したいものをメモっておく。
もう、以下の5つでいい気がする。一応、profile_image_urlも取れる。

↓例
{
  "created_at": "",
  "title": "エンジニアなら知っておきたい生産性を爆上げするツール8選",
  "updated_at": "2020-10-15T09:59:43+09:00",
  "url": "https://qiita.com/yukiji/items/7b5e88c9da7b6f658de5",
  "likes_count": 42
}

## Qiita Query

記事の一覧の取得で、URLでqueryを指定できる。使うのは、下記のAPIのみ。
配列の中にJSONが入っている。
https://qiita.com/api/v2/docs#get-apiv2items

queryでは、いいね数で絞り込みできない。ストック数でなら、サクッと絞り込みできる。↓オプション
https://help.qiita.com/ja/articles/qiita-search-options
-- createdとupdatedで絞り込みできる。
-- createdで絞り込んで検索 -> 画面からはupdated日時を表示でいくか
-- queryは、月までの指定で、その月の1日となる

-- ストック100以上のもの
curl -G \
  --data-urlencode "page=1" \
  --data-urlencode "per_page=3" \
  --data-urlencode "query=:>2020-10 stocks:>100" \
-H 'Authorization: Bearer c32dd88c4bdff501c8ab63f2b72b7b7547a1a44b' 'https://qiita.com/api/v2/items' | jq .

-- ランキングで100件表示
curl -G \
  --data-urlencode "page=1" \
  --data-urlencode "per_page=100" \
  --data-urlencode "query=created:>2020-11 stocks:>262" \
-H 'Authorization: Bearer c32dd88c4bdff501c8ab63f2b72b7b7547a1a44b' 'https://qiita.com/api/v2/items' | \
jq '. | map({ title: .title, url: .url, likes_count: .likes_count, created_at: .created_at ,updated_at: .updated_at, id: .user.id}) | sort_by(.likes_count) | reverse' > ranking.json

-- 2020-09から2020-10までの記事で pageとは・・？
curl -G \
  --data-urlencode "page=1" \
  --data-urlencode "per_page=100" \
  --data-urlencode "query=created:>2020-11-01 created:<2020-10 stocks:>262" \
-H 'Authorization: Bearer c32dd88c4bdff501c8ab63f2b72b7b7547a1a44b' 'https://qiita.com/api/v2/items' | \
jq '. | map({ title: .title, url: .url, likes_count: .likes_count, created_at: .created_at, updated_at: .updated_at, id: .user.id}) | sort_by(.likes_count) | reverse' >

## ページネーションの仕様
https://qiita.com/api/v2/docs#%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%8D%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3

これらのAPIには、1から始まるページ番号を表すpageパラメータと、
1ページあたりに含まれる要素数を表すper_pageパラメータを指定することができます。
pageの初期値は1、pageの最大値は100に設定されています。
また、per_pageの初期値は20、per_pageの最大値は100に設定されています。


## 月ごとの記事を取得
query で created:2017-01 など指定して月毎に取得することで解決
https://developer.kaizenplatform.com/entry/takus/2018-04-26/


## GitHub Actions で commit & push
https://stackoverflow.com/questions/57921401/push-to-origin-from-github-action
-> checkout v2でかなり簡単に作成できるようになったらしい。
   知らなかった。。


## Macのdate
MacはBSD Unixベースらしく、GUN Linuxのコマンドと若干差位がある。
-> なんてこった。
https://tatsuno-system.co.jp/2016/06/27/mac%E3%81%A7date%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%8C%E9%81%95%E3%81%86%E4%BB%B6%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6/

-- 1ヶ月後の日時を表示
gdate "+%Y-%m-%d" -d "1 months"


## 文字列の範囲選択
"2020-10-01".slice(0,7);
// 2020-10

new Date().toISOString().slice(0,7)
// "2020-10"

## ローカルのファイルを上書き
普通に > でファイル上書きやんという。いちいち、rm,touchしなくてええやんという。
ファイルなかったら新規作成してくれるやんという。


##
とりあえず、二月分くらい jsonファイルを作ってみて、それを表示してみる

↓ これで加算できた
let date = new Date(2020, 10, 11);
new Date(date.setMonth(date.getMonth()+1));



## CSSで折りたたむサイドバー
https://www.youtube.com/watch?v=V0O4pY2xX10

## PWA化する
Vanilla JavaSciptでもPWAにできるとのこと。
-> ホーム画面に追加する機能を作りたい。

## 阿部寛の背景のフォント
https://www.dafontfree.net/freefonts-lucida-calligraphy-f133251.htm


## Hacker Newsのランキングサイト。表示する要素やデザインの参考に・・。
https://www.hakaran.com/


## CSSでTENGAを描画する（別件）
できそうだなと。
https://qiita.com/kyoyababa/items/7ee2b96bde46975d0ffc

## NHKの終をCSSで描く
https://ebifry.jp/css/nhk-css/

## TENGAのフォントは Bank Gothic系っぽい
http://webcre8.jp/investigate/love-font-bankgothic.html

## QiitaにCodePenを埋め込める
https://qiita.com/Qiita/items/edae7417214c8e957f54

## Hacker News, はてぶでも同様のサイトを作成する。
同様の手法で、作成できる

HackerNewsには、scoreを取得できる
https://github.com/HackerNews/API
