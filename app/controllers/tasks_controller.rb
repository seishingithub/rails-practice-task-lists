class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
  end

  def create
    @task_list = TaskList.find(params[:task_list_id])
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

end
