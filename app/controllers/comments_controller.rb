class CommentsController < ApplicationController
  # before_action :set_comment, only: [:new, :create]
  before_action :authenticate_user!, only: [:new, :show, :create, :edit, :destroy]
 

   def show
     @comment = Comment.find_by(id: params[:id])
     @user = User.find_by(id: @comment.user_id)
     @comments = @task.comments
   end
  
   def new
    #  board = Board.find(params[:board_id])
     task = Task.find(params[:task_id])
    #  @comment = current_user.comments.build
     @comment = task.comments.build
     session[:previous_url] = request.referer
    
   end

   def create
    #  task = current_user.tasks.find(params[:task_id])
     task = Task.find(params[:task_id]) 
     
     @comment = task.comments.build(comment_params.merge!(user_id: current_user.id))
    #  @comment = current_user.comments.build(comment_params)
     if @comment.save
      redirect_to session[:previous_url], notice: 'コメントを追加'
     else
       flash.now[:error] = '更新できませんでした'
       render :new
     end
   end

   private
   def comment_params
     params.require(:comment).permit(:content)
   end

  #  def set_comment
  #    @comment = Comment.find(params[:id])
  #  end

end
