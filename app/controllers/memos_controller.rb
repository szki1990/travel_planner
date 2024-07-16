class MemosController < ApplicationController
  before_action :set_book, only: [:new, :create, :index, :destroy, :edit, :update]
  before_action :set_memo, only: [:edit, :show, :update, :destroy]
  def new
    @memo = @book.memos.build
  end

  def index
    @memos = @book.memos
  end

  def create
    @memo = @book.memos.build(memo_params)
    if @memo.save
      redirect_to book_memos_path, notice: 'メモが作成されました。'
    else
      render :new
    end
  end

  def show
    
  end

  def edit
  end

  def update
    if @memo.update(memo_params)
      redirect_to book_memos_path(@book), notice: 'メモが更新されました。'
    else
      render :edit
    end
  end
  
  def destroy
    @memo.destroy
    redirect_to book_memos_path(@book), notice: 'メモが削除されました。'
  end 

  private

  def set_memo
    @memo = Memo.find(params[:id])
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def memo_params
    params.require(:memo).permit(:title, :body)
  end
end