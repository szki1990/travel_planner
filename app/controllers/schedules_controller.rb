class SchedulesController < ApplicationController
  before_action :set_book, only: [:new, :create, :index]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def new
    @book = Book.find(params[:book_id])
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime('%Y-%m-%d'), date] }
    @schedule = @book.schedules.build
  end

  def index
    @schedules = @book.schedules
  end

  def create
    @book = Book.find(params[:book_id])
    @schedule = @book.schedules.build(schedule_params)
    @schedule.user_id = current_user.id
    #binding.pry
    if @schedule.save!
      redirect_to book_schedules_path(@book), notice: 'スケジュールを作成しました'
    else
      @start_day = @book.start_day.to_date
      @end_day = @book.end_day.to_date
      @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
      render :new
    end
  end

  def show
    #@schedule
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:title, :budget, :place, :start_date, :end_date, :start_time, :end_time, :schedule_memo)
  end
end