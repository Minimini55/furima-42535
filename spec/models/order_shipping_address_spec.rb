require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  describe '配送情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_shipping_address = FactoryBot.build(:order_shipping_address, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_address).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では保存できないこと' do
        @order_shipping_address.token = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_shipping_address.user_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @order_shipping_address.item_id = nil
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空では登録できない' do
        @order_shipping_address.postal_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが3桁ハイフン4桁の半角文字列でないと保存できない' do
        @order_shipping_address.postal_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureが「---」では保存できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では登録できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空では登録できない' do
        @order_shipping_address.street = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Street can't be blank")
      end

      it 'phone_numberが空では登録できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下では登録できない' do
        @order_shipping_address.phone_number = '123456789'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid. Include 10 or 11 digits')
      end

      it 'phone_numberが12桁以上では登録できない' do
        @order_shipping_address.phone_number = '123456789012'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid. Include 10 or 11 digits')
      end

      it 'phone_numberに半角数字以外が含まれている場合は登録できない' do
        @order_shipping_address.phone_number = '090-1234-5678' # ハイフンを含む
        @order_shipping_address.valid?
        # ↓↓↓ messageはあなたのバリデーション設定に合わせてください
        expect(@order_shipping_address.errors.full_messages).to include('Phone number is invalid. Include 10 or 11 digits')
      end
    end
  end
end
