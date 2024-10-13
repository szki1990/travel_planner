class SchedulesController < ApplicationController
  before_action :set_book, only: [:new, :create, :index, :edit, :show, :update, :destroy]
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  before_action :is_matching_login_user, only: [:index]
  before_action :is_matching_login_user_edit, only: [:edit, :update, :destroy]
  before_action :is_matching_login_user_show, only: [:show]

  def new
    @schedule = @book.schedules.build
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime("%m月%d日"), date] }
  end

  def index
    @start_date = params[:start_date].present? ? Date.parse(params[:start_date]) : @book.start_day.to_date
    @end_date = params[:end_date].present? ? Date.parse(params[:end_date]) : @book.end_day.to_date
    @dates = (@start_date..@end_date).to_a
    @schedules = @book.schedules.where(start_date: @book.start_day..@book.end_day).order(start_time: :asc)
  end

  def create
    schedule_params[:start_date] = Date.parse(schedule_params[:start_date])
    schedule_params[:start_time] = Time.zone.parse("#{schedule_params[:start_date]} #{schedule_params[:start_time]}")

    @schedule = @book.schedules.build(schedule_params)
    @schedule.user_id = current_user.id

    if @schedule.save
      redirect_to book_schedules_path(@book), notice: "スケジュールを作成しました"
    else
      @start_day = @book.start_day.to_date
      @end_day = @book.end_day.to_date
      @date_range = (@start_day..@end_day).map { |date| [date.strftime("%m-%d"), date] }
      render :new
    end
  end

  def show
    @schedules = []
    @schedules.push(@schedule)
    @duration_hours, @duration_minutes = calculate_duration(@schedule.start_time, @schedule.end_time)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def edit
    @start_day = @book.start_day.to_date
    @end_day = @book.end_day.to_date
    @date_range = (@start_day..@end_day).map { |date| [date.strftime("%m-%d"), date] }
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to book_schedules_path(@book), notice: "メモが更新されました"
    else
      @start_day = @book.start_day.to_date
      @end_day = @book.end_day.to_date
      @date_range = (@start_day..@end_day).map { |date| [date.strftime("%m-%d"), date] }
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to book_schedules_path(@book), notice: "スケジュールが削除されました"
  end


  private
    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:title, :budget, :place, :start_date, :end_date, :start_time, :end_time, :schedule_memo, :address, :icon)
    end

    def is_matching_login_user
      unless @book.publicly_visible? || @book.user_id == current_user.id || @book.shared_users.include?(current_user)
        redirect_to public_index_books_path, alert: "アクセスできません。"
      end
    end

    def is_matching_login_user_edit
      if @book.user_id != current_user.id && !@book.shared_users.include?(current_user)
        redirect_to public_index_books_path, alert: "アクセスできません。"
      end
    end

    def is_matching_login_user_show
      if @book.user_id != current_user.id && !@book.shared_users.include?(current_user)
        redirect_to book_schedules_path(book_id: @book.id), flash: { accses_alert: "アクセスできません。" }
      end
    end

    def calculate_duration(start_time, end_time)
      if start_time.present? && end_time.present?
        duration_in_seconds = end_time - start_time
        hours = (duration_in_seconds / 3600).to_i
        minutes = ((duration_in_seconds % 3600) / 60).to_i
        [hours, minutes]
      else
        ""
      end
    end
end
