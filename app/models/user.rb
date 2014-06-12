# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  username          :string(255)      not null
#  name              :string(255)      not null
#  profile_image_url :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  validates :username, :profile_image_url, presence: true

  has_many :tweets
  has_many :inbound_follows, class_name: 'Follow', foreign_key: :followee_id
  has_many :outbound_follows, class_name: 'Follow', foreign_key: :follower_id
  has_many :followers, through: :inbound_follows, source: :follower
  has_many :followees, through: :outbound_follows, source: :followee

  def self.find_or_fetch(username)
    user = User.find_by_username(username)

    if user
      User.fetch_latest_tweets(user)
    else
      self.fetch_by_username(username)
    end
  end

  def self.fetch_latest_tweets(user)
    begin
      user_timeline = self.client.user_timeline(user.username)
    rescue
      return user
    end

    user_timeline.each do |tweetData|
      unless Tweet.find_by_tweeted_at(tweetData.created_at)
        Tweet.create(
          user_id: user.id, url: tweetData.url.to_s,
          full_text: tweetData.full_text, tweeted_at: tweetData.created_at)
      end
    end

    user
  end

  def self.fetch_by_username(username)
    user_timeline = self.client.user_timeline(username)
    user_follows = self.client.friends(username)

    userData = user_timeline.first.user

    user = User.new(name: userData.name,
                    username: userData.screen_name,
                    profile_image_url: userData.profile_image_url.to_s)

    if user.save
      ActiveRecord::Base.transaction do
        user_timeline.each do |tweetData|
          Tweet.create(
            user_id: user.id, url: tweetData.url.to_s,
            full_text: tweetData.full_text, tweeted_at: tweetData.created_at)
        end

        debugger
        user_follows.attrs[:users].each do |friend|
          new_user = User.create(name: friend[:name], username: friend[:screen_name],
                      profile_image_url: friend[:profile_image_url].to_s)

          user.outbound_follows.create(followee_id: new_user.id)
        end
      end

      return user
    end
  end

  def recent_tweets
    self.tweets.sort_by(&:tweeted_at).reverse.first(20)
  end

  private

  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['twitter_consumer_key']
      config.consumer_secret = ENV['twitter_consumer_secret']
    end
  end
end