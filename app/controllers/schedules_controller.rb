class SchedulesController < ApplicationController
  def new
    @schedule = Schedule.new
  end 
  
  def index
    @schedule = Schedule.all
  end 
  
  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user_id = current_user.id
    if @schedule.save
      redirect_to schedules_path, notice: 'スケジュールを作成しました'
    else
      render :new
    end 
    #respond_to do |format|
      #if @schedule.save
        #format.html { redirect_to schedules_path, notice: 'スケジュールを作成しました' }
        #format.json { render :show, status: :created, location: @schedule }
      #else 
        #format.html { render :new }
        #format.json { render json: @schedule.errors, status: :unprocessable_entity }
      #end 
    #end 
  end 
  
  def schedule_params
    params.require(:schedule).permit(:title, :budget, :place, :start_date, :end_date, :start_time, :end_time, :schedule_memo)
  end
end 