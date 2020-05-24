class ItemsController < ApplicationController
  # Allow index and show page only when not sign in
  before_action :authenticate_user!, except: [:index, :show]

  # Show all items
  def index
    apply_filter if params[:search].present?  # If search, show results
    if @items.nil? || @items.empty?   # If results is nil or empty, show all items
      @items = Item.all
    else
      flash[:notice] = nil
    end
  end

  # Show a specific item
  def show
    @item = Item.find(params[:id])
  end

  # Add a new item
  def new
    @item = Item.new
  end

  # Edit an item
  def edit
    @item = Item.find(params[:id])
  end

  # Create a new item
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item
    else
      render 'new'
    end
  end

  # Update an item
  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      redirect_to @item
    else
      render 'edit'
    end
  end

  # Delete an item
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  # Parameters for an item
  private
  def item_params
    params.require(:item).permit(:name, :category, :image, :search)
  end

  # Show search results
  def apply_filter
    @hidden = "hidden"
    @items = Item.search(params[:search])
    flash[:notice] = "No results found" if @items.empty?
  end
end
