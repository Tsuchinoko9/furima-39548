class PurchaseRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_id
  before_action :user_check_move_to_top
  before_action :on_sale_check_move_to_top

  def index
    set_public_key
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
      set_public_key
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    # @item.idの値はcreateアクション前にset_item_idが実行されて取得される
    params.require(:purchase_record_shipping_address)
          .permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
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
    # @itemは事前にset_item_idが実行されて定義される
    return if current_user.id != @item.user_id

    redirect_to root_path
  end

  def on_sale_check_move_to_top
    # @itemは事前にset_item_idが実行されて取得される
    return if PurchaseRecord.where(item_id: @item.id).none?

    redirect_to root_path
  end

  def set_public_key
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

end
