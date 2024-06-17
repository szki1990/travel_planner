class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:edit, :update, :destroy]
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    respond do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'しおりを作成しました' }
        format.json { render :show, status: :created, location: @book }
      else 
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end 
    end 
  end 

  def index
    #@user = current_user
    #@books = @user.books
    @books = current_user.books
  end
  
  def public_index
    @books = Book.public_books
  end 

  def show
    @book = Book.find(params[:id])
  end
  
  def edit
    @book = Book.find(params[:id])
  end 
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book, notice: 'しおりを更新しました'
    else
      render :edit
    end 
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: 'しおりを削除しました'
  end 
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end 
  
  def book_params
    params.require(:book).permit(:title, :image, :start_day, :end_day, :status)
  end
end
