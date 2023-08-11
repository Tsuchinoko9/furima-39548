class PurchaseRecordsController < ApplicationController

  def index
    @purchase_record_shipping_addresses = PurchaseRecordShippingAddress.new
  end

  def create
    @purchase_record_shipping_addresses = PurchaseRecordShippingAddress.new(purchase_record_params)
    if @purchase_record_shipping_addresses.valid?
      @purchase_record_shipping_addresses.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record_shipping_addresses)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
          .merge(user_id: current_user.id, items_id: @item.id)
  end
end
