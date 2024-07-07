class CostsController < ApplicationController
  def new
    @cost = Cost.new
  end

  def index
    @costs = Cost.all
  end

  def show
  end

  def edit
  end
  
  private
  
  def cost_params
    params.require(:cost).permit(:price, :date, :remarks, :consumer, :payment_meshod, :total_price)
  end 
  
end
