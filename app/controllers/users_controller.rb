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
      @public_books = @user.books
    else 
      @public_books = @user.books.publicly_visible
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
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to new_user_registration_path, notice: 'アカウントが削除されました'
  end
  
  def followings
    @title = "Followings"
    @users = @user.following_users
    render 'show_follow'
  end 
  
  def followers
    @title = "Followers"
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