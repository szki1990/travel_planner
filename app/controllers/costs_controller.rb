class CostsController < ApplicationController
  before_action :set_book, only: [:new, :create, :index, :edit, :show, :update, :destroy]
  before_action :set_cost, only: [:show, :edit, :destroy, :edit , :update]
  
  def new
    @cost = @book.costs.build
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
  end
  
  def create
    @cost = @book.costs.build(cost_params)
    if @cost.save
      redirect_to book_costs_path, notice: 'お金管理を作成しました'
    else 
      render :new
    end
  end 

  def index
    @costs = @book.costs.order(:date)
    @total_price = @book.costs.sum(:price)
  end

  def show
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
      render :edit
    end
  end
  
  def destroy
    @cost.destroy
    redirect_to book_costs_path(@book),notice: 'お金管理表が削除されました'
  end 
  
  private
  
  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_cost
    @cost = Cost.find(params[:id])
  end
  
  def cost_params
    params.require(:cost).permit(:price, :date, :remarks, :consumer, :payment_method, :purchase_item, :total_price)
  end 
  
end
