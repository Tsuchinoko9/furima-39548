require 'rails_helper'

RSpec.describe PurchaseRecordShippingAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_record_shipping_address = FactoryBot.build(:purchase_record_shipping_address,
                                                          user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '商品購入ができる場合' do
      it 'token・postal_code・prefecture_id・city・addresses・phone_numberが適切な値で存在し、
          user_idとitem_idが紐づいており、
          buildingが存在する場合に商品購入ができる' do
        expect(@purchase_record_shipping_address).to be_valid
      end 

      it 'token・postal_code・prefecture_id・city・addresses・phone_numberが適切な値で存在し、
          user_idとitem_idが紐づいており、
          buildingが空の場合でも商品購入ができる' do
        @purchase_record_shipping_address.building = ''
        expect(@purchase_record_shipping_address).to be_valid
      end 
    end

    context '商品購入ができない場合' do
      it 'tokenが空では商品購入はできない' do
        @purchase_record_shipping_address.token = ''
        @purchase_record_shipping_address.valid?
        binding.pry
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空では商品購入はできない' do
        @purchase_record_shipping_address.postal_code = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが「3桁ハイフン4桁」の半角文字列でなければ商品購入はできない' do
        @purchase_record_shipping_address.postal_code = '1234567'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Postal code is invalid")
      end

      it 'prefecture_idが1(都道府県が空)では商品購入はできない' do
        @purchase_record_shipping_address.prefecture_id = '1'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では商品購入はできない' do
        @purchase_record_shipping_address.city = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressesが空では商品購入はできない' do
        @purchase_record_shipping_address.addresses = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Addresses can't be blank")
      end

      it 'phone_numberが空では商品購入はできない' do
        @purchase_record_shipping_address.phone_number = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが「10桁以上11桁以内」の半角数値でなければ商品購入はできない' do
        @purchase_record_shipping_address.phone_number = '123-45-6789'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが「9桁以下」では商品購入はできない' do
        @purchase_record_shipping_address.phone_number = '123456789'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが「12桁以上」では商品購入はできない' do
        @purchase_record_shipping_address.phone_number = '123456789012'
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'user_idが紐付いていなければ商品購入はできない' do
        @purchase_record_shipping_address.user_id = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが紐付いていなければ商品購入はできない' do
        @purchase_record_shipping_address.item_id = ''
        @purchase_record_shipping_address.valid?
        expect(@purchase_record_shipping_address.errors.full_messages).to include("Item can't be blank")
      end

    end

  end

end
