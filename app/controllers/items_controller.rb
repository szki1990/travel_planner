class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_check_list, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_book, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:edit, :update, :destroy]
   before_action :is_matching_login_user, only: [:new, :index, :show, :edit, :update, :dastroy]
  
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
  
  def update
    if @item.update(item_params)
      redirect_to book_check_lists_path(@book), notice: 'アイテムを更新しました。'
    else 
      render :edit
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
  
  def toggle_completed
    @item = Item.find(params[:id])
    @item.update(completed: !@item.completed)
  end
  
  private
  
  def set_category
    @category = Category.find(params[:category_id])
  end 
  
  def set_check_list
    @check_list = CheckList.find(params[:check_list_id])
  end 
  
  def set_book
    @book = Book.find(params[:book_id])
  end 
  
  def set_item
    @item = @category.items.find(params[:id])
  end 
  
  def item_params
    params.require(:item).permit(:content)
  end 
  
  def is_matching_login_user
    unless @book.user_id == current_user.id || @book.shared_users.include?(current_user)
      redirect_to book_schedules_path(@book)
    end 
  end 
  
end
