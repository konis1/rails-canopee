class TasksController < ApplicationController
  require 'rubygems'
  require 'twilio-ruby'

  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @my_tasks = Task.joins(garden_plant: [{ garden: :user }]).where('users.id' => current_user.id).where(done: false)
    @current_week_tasks = @my_tasks.where(due_date: DateTime.now.all_week)
    @next_week_tasks = @my_tasks.where(due_date: DateTime.now.next_week.all_week)
    my_activities = Task.select("activity").group("tasks.activity")
    @all_activities = my_activities.map do |acti|
      acti.activity
    end
    @notifications = current_user.notifications
    # @send_sms = Notification.new
    account_sid = ENV['account_sid']
    auth_token = ENV['auth_token']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    # message = @client.messages.create(
    #   body: 'Attention votre compagnon a besoin de votre aide! Rendez vous sur votre espace Soin de Bonnefeuille http://www.bonnefeuille.fr/',
    #   from: 'whatsapp:+14155238886',
    #   to: 'whatsapp:+33683073726'
    # )

  end

  def new
    @garden_plant = GardenPlant.find(params[:garden_plant_id])
    @task = Task.new
  end

  def edit
    @garden_plant = @task.garden_plant
  end

  def create
    @garden_plant = GardenPlant.find(params[:garden_plant_id])
    @task = Task.new(task_params)
    @task.user = current_user
    @garden_plant.tasks = @tasks
    if @task.save
      redirect_to garden_plant_tasks_path(@garden_plant), notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      set_completion_date
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: 'Task was successfully updated.' }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { success: false } }
      end
    end
  end

  def destroy
    @garden_plant = @task.garden_plant
    @task.destroy
    redirect_to garden_plant_tasks_path(@garden_plant), notice: 'Task was successfully destroyed.'
  end

  def update_done
    update_task(params[:id])
    redirect_to garden_plant_path(@task.garden_plant.id), notice: 'Task is done'
  end

  def update_tasks
    update_task(params[:id])
    redirect_to tasks_path, notice: 'Task is done'
  end

  private

  def update_task(id)
    date = DateTime.now
    @task = Task.find(id)
    @task.update(completion_date: date)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:activity, :criticity, :due_date, :completion_date, :done)
  end

  def set_completion_date
    @task.completion_date = DateTime.now if @task.done == true
    @task.save
  end
end
