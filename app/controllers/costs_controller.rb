class CostsController < ApplicationController
  before_action :set_book, only: [:new, :create, :index, :edit, :show, :destroy]
  before_action :set_cost, only: [:show, :edit, :destroy, :edit]
  
  def new
    @cost = @book.costs.build
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
    @costs = @book.costs
  end

  def show
  end

  def edit
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
