class TasksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tasks = Task.all 
  end

  # def show
  #   @board = Board.find(params[:board_id])
  #   @task = @board.tasks.find(params[:task_id])
  #   @comments = @task.comments
  # end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    if @task.save
      redirect_to board_path(board), notice: 'タスクを追加' 
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