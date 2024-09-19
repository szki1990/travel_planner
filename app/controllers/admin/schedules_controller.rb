class Admin::SchedulesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @book = Book.find(params[:book_id])
    @schedules = @book.schedules
  end
end
