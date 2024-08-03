class MembersController < ApplicationController
    before_action :set_book
    
    def create
        @member = @book.members.build(member_params)
        if @member.save
            redirect_to @book, nitice: 'メンバーが追加されました。'
        else 
            redirect_to @book, alert: 'メンバーの追加に失敗しました。'
        end 
    end 
    
    def destroy
        @member = @book.members.find(params[:id])
        @member.destroy
        redirect_to @book, nitice: 'メンバーをこのしおりから削除しました。'
    end 
    
    private
    
    def set_book
        @book = Book.find(params[:book_id])
    end 
    
    def member_params
        params.require(:member).permit(:user_id)
    end 
end
