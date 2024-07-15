class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :create, :destroy]
  before_action :set_check_list, only: [:new, :create, :destroy]
  before_action :set_book, only: [:new, :create, :destroy]
  before_action :set_item, only: [:destroy]
  
  def new
    @item = @category.items.build
  end 
  
  def create
    @item = @category.items.build(item_params.merge(book_id: @book.id))
    if @item.save
      redirect_to book_check_lists_path(@check_list.book, @check_list), notice: 'アイテムを作成しました。'
    else 
      render :new
    end 
  end 
  
  def destroy
    @item.destroy
    redirect_to book_check_lists_path(@book, @check_list, @category), notice: 'アイテムが削除されました。'
  end 
  
  def update_multiple
    item_ids = params[:item_ids]
    items = Item.where(id: item_ids)
    
    items.each do |item|
      item.update(completed: true)
    end
    
    redirect_to book_check_lists_path(@book, @check_list), notice: 'アイテムを更新しました。'
  end
  
  private
  
  def set_category
    @category = Category.find(params[:category_id])
  end 
  
  def set_check_list
    @check_list = CheckList.find(params[:check_list_id])
  end 
  
  def set_book
    @book = @check_list.book
  end 
  
  def set_item
    @item = @category.items.find(params[:id])
  end 
  
  def item_params
    params.require(:item).permit(:content)
  end 
  
end
