class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :find_item, only: [:show, :edit, :update]

  def index
    @items = Item.order(created_at: :desc)
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
    @user = @item.user
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :description, :category_id, :condition_id, :item_condition_id,
      :shipping_fee_payer_id, :prefecture_id, :days_to_ship_id, :day_to_ship_id, :price
    ).merge(user_id: current_user.id)
  end

  def ensure_correct_user
    # URLから編集したい商品の情報を取得する
    @item = Item.find(params[:id])
    # ログイン中のユーザーIDと商品の出品者のIDが一致しない場合
    return if @item.user_id == current_user.id

    # トップページにリダイレクトさせる
    redirect_to root_path
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
