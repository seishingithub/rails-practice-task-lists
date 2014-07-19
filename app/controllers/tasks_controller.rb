class TasksController < ApplicationController
  before_action :get_task_list, only: [:new, :create]

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to root_path, notice: "Task was created successfully!"
    else
      flash.now[:error] = "Your task could not be created"
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :due_date).merge(task_list_id: params[:task_list_id])
  end

  def get_task_list
    @task_list = TaskList.find(params[:task_list_id])
  end

end
