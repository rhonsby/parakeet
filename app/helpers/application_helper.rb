module ApplicationHelper
  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['twitter_consumer_key']
      config.consumer_secret = ENV['twitter_consumer_secret']
    end
  end
end
