class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item_id, only: [:index, :create]
  before_action :user_check_move_to_top, only: [:index, :create]
 

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new
  end

  def create
    @purchase_record_shipping_address = PurchaseRecordShippingAddress.new(purchase_record_params)
    if @purchase_record_shipping_address.valid?
      pay_item
      @purchase_record_shipping_address.save
      redirect_to root_path
    else
      # 入力エラーで遷移時にJavascript動作のため公開鍵の環境変数を定義
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    # @item.idの値はcreateアクション前にset_item_idが実行されて取得される
    params.require(:purchase_record_shipping_address)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :purchase_record_id)
          .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item_id
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price,                            # 商品の値段
      card: @purchase_record_shipping_address.token,  # カードトークン
      currency: 'jpy'                                 # 通貨の種類（日本円）
    )
  end

  def user_check_move_to_top
    # @item.idの値は事前にset_item_idが実行されて取得される
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end
end
