class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book), notice: "コメントが追加されました。"
    else
      redirect_to book_path(book), alert: "送信できません。コメントを入力してください。"
    end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id]), notice: "コメントが削除されました。"
  end

  private
    def book_comment_params
      params.require(:book_comment).permit(:comment)
    end
end
