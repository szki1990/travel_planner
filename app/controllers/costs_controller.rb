class CostsController < ApplicationController
  before_action :set_book, only: [:new, :create, :index, :paid_totals, :edit, :show, :update, :destroy]
  before_action :set_cost, only: [:show, :edit, :destroy, :update]
  before_action :is_matching_login_user, only: [:new, :index, :show, :edit, :update, :dastroy]
  
  def new
    @cost = @book.costs.build(date: Date.today)
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
  end
  
  def create
    @cost = @book.costs.build(cost_params)
    if @cost.save
      redirect_to book_costs_path, notice: 'お金管理を作成しました。'
    else
      flash.now[:alert] = 'エラーが発生しました。入力内容を確認してください。'
      render :new
    end
  end 

  def index
    @costs = @book.costs.order(:date)
    @total_price = @book.costs.sum(:price)
    @grouped_costs = @costs.group_by { |cost| cost.date.strftime('%Y-%m-%d') }
  end 
  
  def payment_method_index
    @costs = @book.costs.order(:date)
    @total_price = @book.costs.sum(:price)
    @grouped_costs = @costs.group_by { |cost| cost.datepayment_method.strftime('%Y-%m-%d') }
  end 

  def show
  end
  
  def paid_totals
    @costs = @book.costs
    @total_price = @book.costs.sum(:price)
    @grouped_costs = @costs.group_by { |cost| cost.consumer }
  end

  def edit
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
  end
  
  def update
    if @cost.update(cost_params)
      redirect_to book_costs_path(@book), notice: 'メモが更新されました'
    else
      @start_day = @book.start_day.to_date
      @end_day = @book.end_day.to_date
      @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
      render :edit
    end
  end
  
  def destroy
    @cost.destroy
    redirect_to book_costs_path(@book), notice: '削除されました'
  end 
  
  private
  
  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_cost
    @cost = Cost.find(params[:id])
  end
  
  def cost_params
    params.require(:cost).permit(:price, :date, :remarks, :consumer, :payment_method, :purchase_item)
  end 
  
  def is_matching_login_user
    unless @book.user_id == current_user.id
      redirect_to public_index_books_path
    end 
  end 
  
end