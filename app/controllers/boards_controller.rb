class BoardsController < ApplicationController
  before_action :set_board, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
   
    def index
      
      @boards = Board.all
      
    end

    def show
      @comments = @board.comments
    end

    def new
      @board = current_user.boards.build
    end

    def create
      binding.pry
      @board = current_user.boards.build(board_params)
      # if @board.save
      #   redirect_to board_path(@board), notice: '保存ができたよ'
      # else
      #   flash.now[:error] = '保存に失敗しました'
      #   render :new
      # end
    end

    private
    def board_params
      params.require(:board).permit(:title, :content, :eyecatch)
    end

    def set_board
      @board = Board.find(params[:id])
    end

end
