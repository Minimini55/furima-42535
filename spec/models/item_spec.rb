require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    it 'imageが空では登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
    end
    it 'nameが空では登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
    end

    it 'nameが41文字以上では登録できない' do
      @item.name = 'a' * 41
      @item.valid?
      expect(@item.errors.full_messages).to include 'Name is too long (maximum is 40 characters)'
    end

    it 'descriptionが空では登録できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Description can't be blank"
    end

    it 'descriptionが1000文字以上では登録できない' do
      @item.description = 'a' * 1001
      @item.valid?
      expect(@item.errors.full_messages).to include 'Description is too long (maximum is 1000 characters)'
    end
    it 'category_idが空では登録できない' do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Category can't be blank"
    end
    it 'item_condition_idが空では登録できない' do
      @item.item_condition_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Item condition can't be blank"
    end
    it 'shipping_fee_payer_idが空では登録できない' do
      @item.shipping_fee_payer_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee payer can't be blank"
    end
    it 'prefecture_idが空では登録できない' do
      @item.prefecture_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture can't be blank"
    end

    it 'days_to_ship_idが空では登録できない' do
      @item.days_to_ship_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Days to ship can't be blank"
    end
    it 'priceが空では登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
    end
    it 'priceが300円以上でないと登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be greater than or equal to 300'
    end

    it 'priceが9000000円以下でないと登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include 'Price must be less than or equal to 9999999'
    end
  end
end
