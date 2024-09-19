class Admin::DashboardsController < ApplicationController
  layout "admin"

  before_action :authenticate_admin!

  def index
    @users = User.all
    if params[:name].present?
      @users = User.where("name LIKE ?", "%#{params[:name]}%")
    end
  end
end
