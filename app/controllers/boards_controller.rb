class BoardsController < ApplicationController
  before_action :set_board, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

   def index

     @boards = Board.all
    
    #  @board = current_user.boards.find(params[:id])
   end

   def show
     @board = Board.find(params[:id])
     @tasks = @board.tasks
     @task = Task.new
     @comments = @task.comments
    #  @comment = Comment.find_by(id: params[:id])
     @comments = Comment.find(params[:id])

   end

   def new
     @board = current_user.boards.build
   end

   def create
     @board = current_user.boards.build(board_params)
     if @board.save
       redirect_to board_path(@board), notice: '保存ができたよ'
     else
       flash.now[:error] = '保存に失敗しました'
       render :new
     end
   end

   def edit
     @board = current_user.boards.find(params[:id])
   end

   def update
     @board = current_user.boards.find(params[:id])
     if @board.update(board_params)
       redirect_to board_path(@board),notice: '更新できました'
     else
       flash.now[:error] = '更新できませんでした'
       render :edit
     end
   end

   def destroy
     board = current_user.boards.find(params[:id])
     board.destroy!
     redirect_to root_path, notice: '削除に成功しました'
   end

   private
   def board_params
     params.require(:board).permit(:title, :description, :eyecatch)
   end

   def set_board
     @board = Board.find(params[:id])
   end
end
