class PurchaseRecordShippingAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id,
                :postal_code, :prefecture_id, :prefecture_id, :city, :addresses, :phone_number, :purchase_record_id

  #purchase_recordsのバリデーション
  with_options presence: true do
    validates :item_id
    validates :user_id
  end

  #shipping_addressesのバリデーション
  with_options presence: true do
    validates :postal_code,       format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id,     numericality: { other_than: 1, message: "can't be blank" } do
    validates :city
    validates :addresses
    validates :phone_number,      numericality: { only_integer: true, length: { in: 10..11 } }
    validates :purchase_record_id
  end

end
