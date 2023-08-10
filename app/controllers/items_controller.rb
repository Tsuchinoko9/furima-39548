class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :user_check_move_to_index, only: [:edit]
  before_action :set_item, only: [ :show, :edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :info, :category_id, :sales_status_id, :shipping_fee_status_id,
                                 :prefecture_id, :scheduled_delivery_id, :price, :image)
          .merge(user_id: current_user.id)
  end

  def user_check_move_to_index
    return if current_user.id == Item.find(params[:id]).user_id

    redirect_to action: :index
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
