class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  
  def index
    @users = User.all
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    end 
  end 
  
  def show
    if @user == current_user
      @public_books = @user.books.order(created_at: :desc)
    else 
      @public_books = @user.books.publicly_visible.order(created_at: :desc)
    end 
    @image_url = if @image.present?
                  "https://pf-travelp-resized-bucket.s3-ap-northeast-1.amazonaws.com/#{@book.image.key}-thumbnail.#{@book.image.blob.content_type.split('/').pop}"
                end 
  end

  def edit
   if @user != current_user
     redirect_to my_page_path(current_user.id)
   end
  end

  def update
    if @user.update(user_params)
      redirect_to my_page_path, notice: 'プロフィールを更新しました'
    else
      render :edit
    end
  end

  def my_page
    @user = current_user
    @image_url = if @image.present?
                  "https://pf-travelp-resized-bucket.s3-ap-northeast-1.amazonaws.com/#{@book.image.key}-thumbnail.#{@book.image.blob.content_type.split('/').pop}"
                end 
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to new_user_registration_path, notice: 'アカウントが削除されました'
  end
  
  def followings
    @title = "フォローしている友達"
    @users = @user.following_users
    render 'show_follow'
  end 
  
  def followers
    @title = "フォロワー"
    @users = @user.follower_users
    render 'show_follow'
  end 

  private
  
  def set_user
    @user = User.find(params[:id])
  end 

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end