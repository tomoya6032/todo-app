class TasksController < ApplicationController
  before_action :set_task, only: [:show]
  before_action :authenticate_user!, only: [:new, :show, :create, :destroy]
<
  # def index
  #   @tasks = Task.all
  # end

  def show

    # @board = Board.find(params[:board_id])
    # @task = @board.tasks.find(params[:id])
    # @comments = @task.comments

  end

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

  def set_task
    @task = Task.find(params[:id])
  end

end
