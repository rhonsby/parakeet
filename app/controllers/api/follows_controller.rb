class Api::FollowsController < ApplicationController
  def mutual_follows
    begin
      @first = User.find_or_fetch(params[:user_one])
      @second = User.find_or_fetch(params[:user_two])
      render partial: 'users/mutual_follows', locals: { users: [@first, @second] }
    rescue
      render json: { errors: ['Sorry, one of your users do not exist'] },
             status: 422
    end
  end
end
