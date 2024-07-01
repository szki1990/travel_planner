class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :edit, :update]
  def new 
    @memo = Memo.new
  end 
  
  def index
    @memos = Memo.all
  end
  
  def create
    @memo = Memo.new(memo_params)
    if @memo.save
      redirect_to memos_path, notice: 'メモが作成されました'
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
      redirect_to memos_path, notice: 'メモが更新されました'
    else 
      render :edit
    end
  end
  
  private
  
  def set_memo
    @memo = Memo.find(params[:id])
  end 
  
  def memo_params
    params.require(:memo).permit(:title, :body)
  end 
end