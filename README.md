
# ブログアプリのテーブル設計

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



## ER図のリンク
https://gyazo.com/8d769bdc398747bc5bc998c7ff6180a9