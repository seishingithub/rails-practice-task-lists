class TasksController < ApplicationController

  def new
    @task = Task.new
    @task_list = TaskList.find(params[:task_list_id])
  end

  def create
    @task_list = TaskList.find(params[:task_list_id])
    @task = Task.create(task_params)
    if @task.save
      redirect_to task_lists_path
    else
      render root_path
    end
  end

  private

  def task_params
    # binding.pry
    params.require(:task).permit(:description).merge(task_list_id: params[:task_list_id])
  end

end
