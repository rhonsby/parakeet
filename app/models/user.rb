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
#  url               :string(255)
#

class User < ActiveRecord::Base
  validates :username, :profile_image_url, presence: true

  has_many :tweets
  has_many :inbound_follows, class_name: 'Follow', foreign_key: :followee_id
  has_many :outbound_follows, class_name: 'Follow', foreign_key: :follower_id
  has_many :followers, through: :inbound_follows, source: :follower
  has_many :followees, through: :outbound_follows, source: :followee

  def self.find_or_fetch(username, options)
    user = User.find_by_username(username)

    unless user
      user = self.fetch_by_username(username, options)
    end

    User.fetch_latest_tweets(user) if options[:tweets]
    User.fetch_latest_follows(user) if options[:follows]

    user
  end

  def self.fetch_latest_tweets(user)
    user_timeline = self.client.user_timeline(user.username)

    user_timeline.each do |tweetData|
      unless Tweet.find_by_tweeted_at(tweetData.created_at)
        Tweet.create(
          user_id: user.id, url: tweetData.url.to_s,
          full_text: tweetData.full_text, tweeted_at: tweetData.created_at)
      end
    end
  end

  def self.fetch_latest_follows(user)
    user_follows = self.client.friends(user.username, count: 1000)

    user_follows.attrs[:users].each do |friend|
      friend_user = User.find_by_username(friend[:screen_name]) ||
             User.create(name: friend[:name], username: friend[:screen_name],
                  profile_image_url: friend[:profile_image_url].to_s,
                  url: "https://twitter.com/#{friend[:screen_name]}")

      unless Follow.where(followee_id: friend_user.id, follower_id: user.id).any?
        user.outbound_follows.create(followee_id: friend_user.id)
      end
    end
  end

  def self.fetch_by_username(username, options)
    userData = self.client.user(username)
    user = User.create(name: userData.name,
                    username: userData.screen_name,
                    profile_image_url: userData.profile_image_url.to_s,
                    url: "https://twitter.com/#{userData.screen_name}")

    return user
  end

  def self.find_mutual_follows(user1, user2)
    u1_followees = user1.followees
    u2_followees = user2.followees

    u1_followees.select do |followee|
      followee if u2_followees.include?(followee)
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
