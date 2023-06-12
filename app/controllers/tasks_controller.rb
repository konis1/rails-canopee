class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @my_tasks = Task.joins(garden_plant: [{ garden: :user }]).where('users.id' => current_user.id)
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
    date = DateTime.now
    @task = Task.find(params[:id])
    @task.update(done_time: date)
    redirect_to garden_plant_path(@task.garden_plant.id), notice: 'Task is done'
  end

  private

  def task_params
    params.require(:task).permit(:activity, :criticity, :due_date, :done_time)
  end
end
