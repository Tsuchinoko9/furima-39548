## usersテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last-name          | string | null: false |
| first-name         | string | null: false |
| last-name-kana     | string | null: false |
| first-name-kana    | string | null: false |
| birth-date         | string | null: false |

### Association

- has_many :items
- has_many :purchase-records


## itemsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| info                | text       | null: false                    |
| category            | string     | null: false                    |
| sales-status        | string     | null: false                    |
| shipping-fee-status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled-delivery  | string     | null: false                    |
| price               | integer    | null: false                    |
| user-id             | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- has_one :purchase-records


## purchase-recordsテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| item-id       | references | null: false, foreign_key: true |
| user-id       | references | null: false, foreign_key: true |

### Association

- belongs_to :users
- belongs_to :items
- belongs_to :shipping-addresses


## shipping-addressesテーブル

| Column       | Type    | Options     |
| ------------ | ------- | ----------- |
| postal-code  | string  | null: false |
| prefecture   | string  | null: false |
| city         | string  | null: false |
| addresses    | string  | null: false |
| building     | string  |             |
| phone-number | integer | null: false |

### Association

- belongs_to :purchase-records


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
