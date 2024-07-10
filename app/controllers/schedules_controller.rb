class SchedulesController < ApplicationController
  before_action :set_book, only: [:new, :create, :index, :edit, :show, :update, :destroy]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def new
    @schedule = @book.schedules.build
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m月%d日'), date] }
  end

  def index
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : @book.start_day.to_date
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : @book.end_day.to_date
    @dates = (@start_date..@end_date).to_a
    @schedules = @book.schedules.where(start_date: @book.start_day..@book.end_day).order(start_time: :asc)
  end

  def create
    @book = Book.find(params[:book_id])
    schedule_params[:start_date] = Date.parse(schedule_params[:start_date])
    schedule_params[:start_time] = Time.zone.parse("#{schedule_params[:start_date]} #{schedule_params[:start_time]}")
    
    @schedule = @book.schedules.build(schedule_params)
    @schedule.user_id = current_user.id

    if @schedule.save
      redirect_to book_schedules_path(@book), notice: 'スケジュールを作成しました'
    else
      @start_day = @book.start_day.to_date
      @end_day = @book.end_day.to_date
      @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
      render :new
    end
  end

  def show
    @book = @schedule.book
  end
  
  def edit
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
  end 
  
  def update
    if @schedule.update(schedule_params)
      redirect_to book_schedules_path(@book), notice: 'メモが更新されました'
    else
      @start_day = @book.start_day.to_date
      @end_day = @book.end_day.to_date
      @date_range = (@start_day..@end_day).map { |date| [date.strftime('%m-%d'), date] }
      render :edit
    end
  end
  
  def destroy
    @schedule.destroy
    redirect_to book_schedules_path(@book), notice: '削除されました'
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