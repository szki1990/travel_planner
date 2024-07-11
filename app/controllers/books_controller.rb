class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:public_index, :show]
  before_action :authenticate_user!, except: [:public_index]
  before_action :set_book, only: [:edit, :show, :destroy]
  
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    respond_to do |format|
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
    @books = current_user.books.order(start_day: :asc)
  end
  
  def public_index
    @books = Book.all
    if params[:title].present?
      @books = Book.where('title LIKE ?', "%#{params[:title]}%")
    end 
  end 

  def show
    @book_comment = BookComment.new
    @schedules = @book.schedules
    @total_budget = @schedules.sum(:budget)
  end
  
  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end 
  
  def update
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id), notice: 'しおりを更新しました'
  end
  
  def destroy
    @book.destroy
    redirect_to books_path, notice: 'しおりを削除しました'
  end 
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end 
  
  def book_params
    params.require(:book).permit(:title, :image, :start_day, :end_day, :public_status)
  end
end