class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  skip_before_action :authenticate_user!, only: [:public_index, :show]
  before_action :authenticate_user!, except: [:public_index]
  before_action :set_book, only: [:show, :destroy, :update, :edit, :destroy_image]
  
  def new
    @book = Book.new
    @followers = current_user.following_users
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      @book.shared_user_ids = params[:book][:shared_user_ids]
      redirect_to books_path, notice: 'しおりを作成しました'
    else
      @followers = current_user.following_users
      render :new
    end
  end

  def index
    @books = current_user.books.order(start_day: :asc)
    @shared_books = current_user.shared_books
  end
  
  def public_index
    @public_books = Book.publicly_visible.order(created_at: :desc)
    @books = Book.all
    if params[:title].present?
      @public_books = Book.publicly_visible.where('title LIKE ?', "%#{params[:title]}%")
    end 
  end 
  
  def show
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
    @shared_users = @book.shared_users
    @image = @book.image if @book.image.attached?
    @image_url = if @image.present?
                  "https://pf-travelp-resized-bucket.s3-ap-northeast-1.amazonaws.com/#{@book.image.key}-thumbnail.#{@book.image.blob.content_type.split('/').pop}"
                end 
  end
  
  def edit
    @followers = current_user.following_users
  end
  
  def update
    if @book.update(book_params)
      sleep(3)
      @book.shared_user_ids = params[:book][:shared_user_ids]
      redirect_to book_path(@book), notice: 'しおりを更新しました'
    else
      @followers = current_user.following_users
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    redirect_to books_path, notice: 'しおりを削除しました'
  end 
  
  def destroy_image
    @book.image.purge
    redirect_to edit_book_path(@book), notice: '画像が削除されました。'
  end 
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end 
  
  def book_params
    params.require(:book).permit(:title, :image, :start_day, :end_day, :public_status, :address, :latitude, :longitude, :shared_user_ids)
  end
  
  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id || @book.shared_users.include?(current_user)
      redirect_to public_index_books_path
    end 
  end 
  
end