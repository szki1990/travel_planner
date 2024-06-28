class SchedulesController < ApplicationController
  def new
    @schedule = Schedule.new
  end 
  
  def index
    @schedules = Schedule.all
  end 
  
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
      redirect_to schedules_path, notice: 'スケジュールを作成しました'
    else
      render :new
    end 
  end 
  
  def show
    @schedule = Schedule.find(params[:id])
  end 
  
  def schedule_params
    params.require(:schedule).permit(:title, :budget, :place, :start_date, :end_date, :start_time, :end_time, :schedule_memo)
  end
end 