class BoardsController < ApplicationController
  before_action :set_board, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def index
    @boards = Board.all 
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path(@board), notice: '保存ができたよ'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  private
  def board_params
    params.require(:board).permit(:title, :description)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
