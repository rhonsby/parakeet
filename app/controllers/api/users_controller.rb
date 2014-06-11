class Api::UsersController < ApplicationController
  def show
    begin
      @user = User.find_or_fetch(params[:username])
      render partial: 'users/user', locals: { user: @user }
    rescue
      render json: { errors: ['Sorry, that user does not exist'] }, status: 422
    end
  end

  def create
  end
end
