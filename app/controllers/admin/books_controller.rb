class Admin::BooksController < ApplicationController
    
    def index
        @books = Book.all
        @public_books = Book.publicly_visible
    end 
    
    def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to admin_books_path, notice: 'しおりを削除しました。'
    end 
    
    def show
        @book = Book.find(params[:id])
        @book_comment = BookComment.new
    end
    
    private
  
  def book_params
    params.require(:book).permit(:title, :image, :start_day, :end_day, :public_status, :address, :latitude, :longitude)
  end
  
end
