class TasksController < ApplicationController
  before_action :set_task, only: [:show]
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    # @board = Board.find(params[:board_id])
    # @task = @board.task.find(params[:id]) 

  end

  def new
    board = current_user.boards.find(params[:board_id])
    @task = board.tasks.build
    
  end


  def create
    board = current_user.boards.find(params[:board_id])
    @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
    if @task.save

      redirect_to board_path(board), notice: 'タスクを追加'

    else
     flash.now[:error] = 'タスクを追加できませんでした'
     render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:board_id])
  end

  def update
    @task = current_user.tasks.find(params[:board_id])
    if @task.update(task_params)
      redirect_to board_task_path(@task),notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :eyecatch)
  end

  
  def set_task
    @task = Task.find(params[:board_id])
  end

end
