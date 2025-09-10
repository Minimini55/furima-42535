class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipping_fee_payer
  belongs_to :prefecture
  belongs_to :days_to_ship

  # 空の投稿を保存できないようにする
  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :item_condition_id
    validates :shipping_fee_payer_id
    validates :prefecture_id
    validates :days_to_ship_id
  end

  # priceが¥300から¥9,000,000までのとき以外且つ全角文字を含むときは保存できないようにする
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }

  # 商品名が40文字を超えているときは保存できないようにする
  validates :name, length: { maximum: 40 }

  # 商品の説明文が1000文字を超えているときは保存できないようにする
  validates :description, length: { maximum: 1_000 }

  # userが紐ついていないと保存できなようにする
  validates :user, presence: true
end
