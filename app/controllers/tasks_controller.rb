class TasksController < ApplicationController
  before_action :get_task_list, only: [:new, :create, :update]

  def new
    @task = Task.new
    # @task = @task_list.tasks.new
  end

  def create
    @task = Task.create(task_params)
    # @task = @task_list.tasks.create(task_params)

    if @task.save
      redirect_to root_path, notice: "Task was created successfully!"
    else
      flash.now[:error] = "Your task could not be created"
      render :new
    end
  end

  def update
    @task = Task.update(completed:true)
    # @task = @task_list.tasks.update(completed:true)
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :due_date).merge(task_list_id: params[:task_list_id])
  end

  def get_task_list
    @task_list = TaskList.find(params[:task_list_id])
  end

end
