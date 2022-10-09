class CommentsController < ApplicationController
  # before_action :set_comment, only: [:create]
  before_action :authenticate_user!

   def show

   end
  
   def new
    #  board = Board.find(params[:board_id])
    #  task = Task.find(params[:task_id])
    #  @comment = board.comments.build
     @comment = current_user.boards.build
   end

   def create
     board = Board.find(params[:id])
    #  @comment.create(user_id: current_user.id)
     @comment = current_user.comments.build(comment_params)

     if @comment.save
       redirect_to task_path(@board), notice: 'コメントを追加'
     else
       flash.now[:error] = '更新できませんでした'
       render :new
     end
   end

  #  private
  #  def comment_params
  #    params.require(:comment).permit(:content)
  #  end

  #  def set_comment
  #    @comment = Comment.find(params[:task_id])
  #    @task = Task.find(params[:id])
  #  end

end
