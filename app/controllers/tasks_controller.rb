class TasksController < ApplicationController
  # before_action :set_task, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end
  
  def show
    @board = Board.find(params[:board_id])
    # @task = Task.find(id: params[:board_id][:task_id])
    @task = Task.find(params[:id])
    # @comments = Comment.new
    @comments = @task.comments
    # @comments_count = Comments.where(task_id: @task.id).count
    
  end

  def new
    # board = current_user.boards.find(params[:board_id])
    # @task = board.tasks.build
    board = Board.find(params[:board_id])
    @task = board.tasks.build
    session[:previous_url] = request.referer 
  end


  def create
    # board = current_user.boards.find(params[:board_id])
    # @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params.merge!(user_id: current_user.id))
    session[:previous_url] 

    if @task.save
      redirect_to board_path(board), notice: 'タスクを追加'
    else
     flash.now[:error] = 'タスクを追加できませんでした'
     render :new
    end
  end

  def edit
    @board = Board.find(params[:board_id])
    @task = current_user.tasks.find(params[:id])
  end

  def update
    
    @board = Board.find(params[:board_id])
    # @board = current_user.boards.find(params[:id])
    # @task = Task.find(params[:id])
    @task = current_user.tasks.find(params[:id])
    
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task),notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:board_id])
    task.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end
  
private
  def task_params
     params.require(:task).permit(:title, :content, :eyecatch, :id,).merge(board_id: params[:board_id])
  end
  
  # private
  # def update_task_params
  #   params.require(:task).permit(:title, :content, :eyecatch, :id) #（rimit入れる）
  # end
  
  def set_task
    @task = Task.find(params[:id])
    # @board = Board.find(params[:board_id])
  end
  
end
