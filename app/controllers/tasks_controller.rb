class TasksController < ApplicationController
  before_action :authenticate_user!
  

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Task.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_tasks_path(board), notice: 'タスクを追加' 
    else
     flash.now[:error] = '更新できませんでした'
     render :new
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end

end