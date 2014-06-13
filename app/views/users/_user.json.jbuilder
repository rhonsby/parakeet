json.cache! [user.recent_tweets.map(&:tweeted_at).join] do
  json.extract! user, :id, :username, :name, :profile_image_url, :url
  json.tweets user.recent_tweets, partial: 'tweets/tweet', as: :tweet
end