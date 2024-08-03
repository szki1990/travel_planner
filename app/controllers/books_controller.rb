class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  skip_before_action :authenticate_user!, only: [:public_index, :show]
  before_action :authenticate_user!, except: [:public_index]
  before_action :set_book, only: [:show, :destroy]
  
  def new
    @book = Book.new
    @followers = current_user.followers
    #@book.members.build
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
    @public_books = Book.publicly_visible
    @books = Book.all
    if params[:title].present?
      @public_books = Book.publicly_visible.where('title LIKE ?', "%#{params[:title]}%")
    end 
  end 
  
  def show
    #@members = @book.members.includes(:user)
    #@member = @book.members.new
    @book_comment = BookComment.new
    @schedules = @book.schedules
    @total_budget = @schedules.sum(:budget)
    @map_data = @schedules.map do |schedule|
      {
        title: schedule.title,
        lat: schedule.latitude,
        lng: schedule.longitude,
      }
    end 
  end
  
  def edit
  end 
  
  def update
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
    params.require(:book).permit(:title, :image, :start_day, :end_day, :public_status, :address, :latitude, :longitude)
  end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to public_index_books_path
    end 
  end 
  
end