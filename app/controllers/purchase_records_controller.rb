class PurchaseRecordsController < ApplicationController
  before_action :set_item_id, only: [:index, :create]

  def index
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_params)
    if @purchase_record_shipping_address.valid?
      @purchase_record_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    # @item.idの値はcreateアクション前にset_item_idが実行されて取得される
    params.require(:purchase_record_shipping_address)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :purchase_record_id)
          .merge(user_id: current_user.id, item_id: @item.id)
  end

  def set_item_id
    @item = Item.find(params[:item_id])
  end
end
