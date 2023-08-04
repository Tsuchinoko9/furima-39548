class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :info
    validates :category_id
    validates :sales_status_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
    validates :price
  end

  validates :price, numericality:{ only_integer: true, 
                                   greater_than_or_equal_to: 300, 
                                   less_than_or_equal_to: 9999999 },
                    format: { with: /\A[0-9]+\z/ }
end
