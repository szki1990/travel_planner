class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to books_path
  end 

  def index
    @user = current_user
    @books = @user.books
  end

  def show
    @book = Book.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end 
  private
  
  def book_params
    params.require(:book).permit(:title, :image, :start_day, :end_day)
  end
end
