class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end 
  
  def edit
    @user = User.find(params[:id])
   if @user != current_user
     redirect_to user_path(current_user.id)
   end 
  end 
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path
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
