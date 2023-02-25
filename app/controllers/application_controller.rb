class ApplicationController < ActionController::Base
  # before_action :set_board, only: [:show]
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
   def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
   end
end
