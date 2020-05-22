class ItemsController < ApplicationController
  def index
    apply_filter if params[:search].present?
    if @items.nil? || @items.empty?
      @items = Item.all
    else
      flash[:notice] = nil
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :category, :image, :search)
  end

  def apply_filter
    @hidden = "hidden"
    @items = Item.search(params[:search])
    flash[:notice] = "No results found" if @items.empty?
  end
end
