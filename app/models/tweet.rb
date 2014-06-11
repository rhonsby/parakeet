# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  tweeted_at :string(255)      not null
#  full_text  :string(255)      not null
#  url        :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Tweet < ActiveRecord::Base
  belongs_to :user, primary_key: :twitter_id, foreign_key: :user_id
end
