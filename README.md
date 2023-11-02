# ふんわりブログ
気軽にアイデアや考えをアウトプットできるブログサイトです。<br>レスポンシブ対応しているので、スマホ等からも閲覧可能です。
![portfolio_index](https://user-images.githubusercontent.com/67918972/94553575-ae246180-0293-11eb-8c12-7b0806de8b06.jpg)

コンセプト：人目を気にせず気軽にアウトプットできるブログアプリ<br>
特徴１　非公開で投稿できるので未完成の記事やアイデアを投稿できる<br>
特徴２　アプリ内で公開も可能、いいねやコメントでフィードバックもできます<br>
特徴３　本文の入力は音声でも可能、画像も複数いれて投稿できます

# URL
AWS版（現在公開停止中）：http://3.113.47.133/<br>
Heroku版（現在公開停止中）：https://eiji-blog-app.herokuapp.com/<br>「ゲストでログイン」ボタンからメールアドレス等の入力不要でログインできます。<br>※AWS版はHTTPS化やドメイン設定ができていないため、以下２点の機能が動きません。
- SNS認証機能（Facebook、Google）
- 音声認識機能

# 使用技術
- Ruby 2.6.5
- Ruby on Rails 6.0.3.2
- MySQL 5.6
- Nginx
- AWS
  - EC2
  - S3
- Capistrano
- RSpec
- Web Speech API

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
  - 記事の新規投稿、編集、削除
  - 音声入力(Web Speech API)
  - 公開、非公開設定
  - リッチテキスト
- いいね機能(Ajax)
  - ランキング機能
- コメント機能
- いいね、コメント通知機能
- ページネーション機能(kaminari)
- 検索機能

# テーブル設計

## users テーブル（ユーザーのテーブル）

| Column      | Type   | Options     |
| ----------- | ------ | ----------- |
| nickname    | string | null: false |
| email       | string | null: false |
| password    | string | null: false |
| firstname   | string | null: false |
| lastname    | string | null: false |
| birthday    | date   | null: false |

### Association

- has_many :articles
- has_many :comments
- has_many :sns_credentials

## articles テーブル（投稿記事のテーブル）

| Column  | Type        | Options                        |
| ------- | ----------- | ------------------------------ |
| title   | string      | null: false                    |
| status  | text        | null: false                    |
| user    | references  | null: false, foreign_key: true |

### Association

- has_many :comments
- has_one_attached :image
- has_rich_text :body
- belongs_to :user
- acts_as_taggable
- enum status: {released: 0, unreleased: 1}

## comments テーブル（コメントのテーブル）

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| text     | text       | null: false                    |
| article  | references | null: false, foreign_key: true |
| user     | references | null: false, foreign_key: true |


### Association

- belongs_to :article
- belongs_to :user

## tags テーブル（タグのテーブル）

| Column         | Type     | Options     |
| -------------- | -------- | ----------- |
| name           | string   | null: false |
| taggings_count | integer  | null: false |

## taggings テーブル（tagsとarticlesの中間テーブル）

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| tag           | references | null: false, foreign_key: true |
| taggable_type | string     | null: false                    |
| taggable_id   | integer    | null: false                    |
