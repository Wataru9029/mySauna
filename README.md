# MySweetSauna
![スクリーンショット 2021-03-10 20 50 18](https://user-images.githubusercontent.com/43335573/110625007-40854580-81e2-11eb-878b-d9358440db52.png)

サウナ施設の情報を共有したり、地図から登録済みサウナ施設を探せたり、様々な機能を取り揃えたサウナ好きのためのWebアプリケーションです。

# URL
https://www.mysauna.tk/

* トップページ右上にあるログインボタンをクリックしログイン画面に遷移します。
* 「簡単ログイン(閲覧用)」のボタンをクリックすると、フォーム入力することなくログイン可能です。

# 制作の背景
* サウナ施設の共有と備忘録のために作成しました。
* 施設によっては感染対策が施されていないことがあり、このご時世サウナに行きづらいと感じていたので、おすすめ度と感染対策度の星評価を登録できるようにしました。
* また現在地から1番近いサウナを探せるように"マップから探す機能"を作成しました。

# 機能一覧
## ユーザー機能
![mysauna_login mov](https://user-images.githubusercontent.com/43335573/111643541-647c0300-8842-11eb-8181-bd51bfb65bfe.gif)

* ユーザー登録・編集・削除(deviseのgemを使用)
* ゲストログイン
* プロフィール画像の登録・編集(carrierwaveのgemを使用)
* 管理者権限のあるユーザーのみ、ユーザー管理可能(rails_adminのgemを使用)

## サウナ施設の投稿機能
![mysauna_post mov](https://user-images.githubusercontent.com/43335573/111643628-72318880-8842-11eb-93fd-ec41e157b645.gif)

* お気に入りのサウナ施設(施設の写真、名前、住所等)を投稿
* 一覧表示、詳細表示
* 地図表示(Google Maps API)
* タグ付け機能(acts-as-taggable-onのgemを使用)
* 投稿へのいいね機能(非同期通信)
* 投稿へのコメント機能
* サウナ施設の検索機能(施設名、説明文、住所のOR検索)

## フォロー機能
![mysauna_follow mov](https://user-images.githubusercontent.com/43335573/111643517-5fb74f00-8842-11eb-9afd-3cdd7a4fa5ba.gif)

* ユーザーのフォロー・フォロー解除(非同期)
* フォロー中のユーザーとフォロワーの一覧表示

## メッセージ機能
![mysauna_message mov](https://user-images.githubusercontent.com/43335573/111643851-a311bd80-8842-11eb-9d5d-cd54c22b5629.gif)

* ユーザー同士のメッセージ機能(作成、削除)

## 通知機能
![mysauna_notification mov](https://user-images.githubusercontent.com/43335573/111643587-6c3ba780-8842-11eb-87d7-0b884faffba2.gif)

* 以下のタイミングでユーザーに通知を送信(自分の投稿がいいねされた時, 自分の投稿にコメントされた時, 他ユーザーからフォローされた時)
* 一覧表示
* 未確認の通知がある場合はマークを表示

## その他の機能
![mysauna_mapindex mov](https://user-images.githubusercontent.com/43335573/111643558-6776f380-8842-11eb-8348-5a76b6f9b430.gif)

* ランキング機能(いいね順、高評価順、感染対策順)
* 登録済みサウナ施設をマップから探す機能(Google Maps API)
* ページネーション機能(kaminariのgemを使用)
* HTTPS通信(AWS Certificate Manager)
* レスポンシブ対応

# 環境・使用技術
## フロントエンド
* HTML/CSS
* JavaScript, jQuery
* Bootstrap 4.3.1

## バックエンド
* Ruby 2.5.3
* Ruby on Rails 5.2.2

## 開発環境
* MySQL
* Docker/docker-compose

## 本番環境
* AWS(EC2, RDS, VPC, ALB, S3, Route53, ACM)
* Nginx
* Puma
* CircleCIにてdocker-composeよりコンテナを構築し、Capistranoを使って自動デプロイ
* MariaDB

## テスト
* Rspec(単体・統合)
* CircleCIにてdocker-composeよりコンテナを構築し、自動テスト

## その他使用技術
* Google Maps API
* 非同期通信(投稿へのいいね、ユーザーのフォロー)
* コードの自動修正(Rubocop)
* Githubの活用(プルリクエスト、マージ等)

# インフラ構成図
<img style="max-width:100%;" alt="readme_infrastructure" src="https://user-images.githubusercontent.com/43335573/107848024-cc01f580-6e33-11eb-916a-62991825b94f.png">
