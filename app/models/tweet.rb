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
  belongs_to :user

  def formatted_date
    self.tweeted_at.to_time.strftime('%l:%M %p - %-d %b %Y')
  end
end
