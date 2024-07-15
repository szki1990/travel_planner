class CategoriesController < ApplicationController
  before_action :set_check_list, only: [:new, :create, :destroy]
  before_action :set_book, only: [:new, :create, :destroy]
  before_action :set_category, only: [:destroy]
  
  def new
    @category = @check_list.categories.build
  end 
  
  def create
    @category = @check_list.categories.build(category_params.merge(book_id: @book.id))
    if @category.save
      redirect_to book_check_lists_path(@check_list.book, @check_list), notice: 'カテゴリーを作成しました。'
    else 
      render :new
    end 
  end 
  
  def destroy
    @category.destroy
    redirect_to book_check_lists_path(@book, @check_list), notice: 'カテゴリーが削除されました。'
  end 
  
  private
  
  def set_check_list
    @check_list = CheckList.find(params[:check_list_id])
  end
  
  def set_book
    @book = @check_list.book
  end 
  
  def set_category
    @category = @check_list.categories.find(params[:id])
  end 
  
  def category_params
    params.require(:category).permit(:name)
  end 
  
end
