class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
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

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :condition_id, :item_condition_id,
      :shipping_fee_payer_id, :prefecture_id, :days_to_ship_id, :day_to_ship_id, :price
    ).merge(user_id: current_user.id)
  end
end
