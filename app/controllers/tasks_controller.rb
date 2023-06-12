class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @my_tasks = Task.joins(garden_plant: [{ garden: :user }]).where('users.id' => current_user.id)
    my_activities = Task.select("activity").group("tasks.activity")
    @all_activities = my_activities.map do |acti|
      acti.activity
    end
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
    @task = @task.new(task_params)
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
      redirect_to garden_plant_tasks_path(@garden_plant), notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
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
    @task.update(done_time: date)
  end

  def task_params
    params.require(:task).permit(:activity, :criticity, :due_date, :done_time)
  end
end
