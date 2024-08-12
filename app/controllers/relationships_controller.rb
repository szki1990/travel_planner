class RelationshipsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @user = User.find(params[:user_id])
        current_user.follow(@user)
        redirect_to @user
    end 
    
    def destroy
        @relationship = current_user.active_relationships.find(params[:id])
        @user = @relationship.following
        if @relationship
          @relationship.destroy
          redirect_to @user, notice: 'フォローを解除しました。'
        else
          redirect_to @user, alert: 'フォロー解除できませんでした。'
        end
    end
end
