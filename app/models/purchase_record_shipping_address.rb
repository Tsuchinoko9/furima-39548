class PurchaseRecordShippingAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id,
                :postal_code, :prefecture_id, :prefecture_id, :city, :addresses, :building, :phone_number,
                :token

  # クレジットカードのトークンのバリデーション
  validates :token, presence: true

  # purchase_recordsのバリデーション
  with_options presence: true do
    validates :item_id
    validates :user_id
  end

  # shipping_addressesのバリデーション
  with_options presence: true do
    validates :postal_code,   format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :addresses
    validates :phone_number,  format: { with: /\A[0-9]{10}$|^[0-9]{11}\z/ }
  end

  def save
    # purchase_recordsテーブルにデータを保存する処理
    purchase_record = PurchaseRecord.create(item_id: item_id, user_id: user_id)
    # shipping_addressesテーブルにデータを保存する処理
    # purchase_record_idには、上の行で定義した変数purchase_recordのidを指定する
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, 
                           addresses: addresses, building: building, phone_number: phone_number,
                           purchase_record_id: purchase_record.id)
  end
end
