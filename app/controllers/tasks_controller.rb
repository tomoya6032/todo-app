class TasksController < ApplicationController
  # before_action :set_task, only: [:show]
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  # def index
  #   @tasks = Task.all 
  # end

  def show
    @task = Task.find(params[:id])
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
    #@task = current_user.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_task_path(task), notice: 'タスクを追加' 
    else
     flash.now[:error] = '更新できませんでした'
     render :new
    end
  end

  private
  def board_task_params
    params.require(:task).permit(:title, :content)
  end

  # def set_board_task
  #   @task = Task.find(params[:id])
  # end

end