class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    board = Task.find(params[:board_id])
    board.tasks.create(user_id: current_user.id)
    redirect_to board_tasks_path(board)
  end
end