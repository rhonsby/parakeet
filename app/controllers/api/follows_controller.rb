class Api::FollowsController < ApplicationController
  def mutual_follows
    begin
      user1 = User.find_or_fetch(params[:userOne], follows: true)
      user2 = User.find_or_fetch(params[:userTwo], follows: true)
      mutual_follows = User.find_mutual_follows(user1, user2)

      render partial: 'users/mutual_follows',
             locals: { users: [user1, user2], mutual_follows: mutual_follows }
    rescue
      render json: { errors: ['Sorry, one of your users do not exist'] },
             status: 422
    end
  end
end
