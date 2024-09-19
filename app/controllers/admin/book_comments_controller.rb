class Admin::BookCommentsController < ApplicationController
  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to admin_books_path, notice: "コメントを削除しました"
  end
end
