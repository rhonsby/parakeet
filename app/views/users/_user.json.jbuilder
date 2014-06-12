json.extract! user, :id, :username, :name, :profile_image_url
json.tweets user.recent_tweets, partial: 'tweets/tweet', as: :tweet