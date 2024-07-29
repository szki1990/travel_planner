class Admin::BaseController < ApplicationController
    before_action :authenticate_admin!
    
    private
    
    def authenticate_admin!
        redirect_to root_path, alert: '管理者専用ページ' unless current_user.admin?
    end 
    
end 