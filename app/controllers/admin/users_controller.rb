class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :destroy]
  
  def show
    @books = @user.books
  end 
  
  def destroy
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end 
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end 
  
end
