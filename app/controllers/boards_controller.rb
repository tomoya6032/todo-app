class BoardsController < ApplicationController
  before_action :set_article, only: [:show]
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

end
