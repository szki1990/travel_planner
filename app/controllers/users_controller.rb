class UsersController < ApplicationController
  
  def index
    @users = User.all
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    end 
  end 
  
  def show
    @user = User.find(params[:id])
    if @user == current_user
      @public_books = @user.books
    else 
      @public_books = @user.books.publicly_visible
    end 
  end

  def edit
    @user = User.find(params[:id])
   if @user != current_user
     redirect_to my_page_path(current_user.id)
   end
  end

  def update
    @user = User.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end