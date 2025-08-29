# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |



### Association
- has_many :items
- has_many :orders
- has_many :shipping_addresses


## items テーブル

| Column               | Type    | Options                        |
| -------------------- | ------- | -----------------------------  |
| name                 | string  | null: false                    |
| description          | text    | null: false                    |
| category_id          | integer | null: false                    |
| item_condition_id    | integer | null: false                    |
| shipping_fee_payer_id| integer | null: false                    |
| prefecture_id        | integer | null: false                    |
| days_to_ship_id      | integer | null: false                    |
| price                | integer | null: false                    | 
| trading_status_id    | integer | null: false                    | 
| seller_id            | bigint  | null: false, foreign_key: true |

### Association
- has_one :order
- belongs_to :seller, class_name: 'User'


## orders テーブル

| Column                | Type    | Options                        |
| user_id               | bigint  | null: false, foreign_key: true |
| item_id               | bigint  | null: false, foreign_key: true |
| shipping_address_id   | bigint  | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- belongs_to :shipping_address

## shipping_addresses テーブル

| Column                | Type    | Options                        |
| user_id               | bigint  | null: false, foreign_key: true |
| postal_code           | string  | null: false                    |
| prefecture_id         | integer | null: false                    |
| city                  | string  | null: false                    |
| street                | string  | null: false                    |
| building              | string  |                                |
| phone_number          | string  | null: false                    |

### Association
- has_many :orders
- belongs_to :user
