require 'spec_helper'

describe Tweet do
  let(:user) do
    User.create(
      username: 'foobar',
      name: 'foobar',
      profile_image_url: 'http://bit.ly/19Mo8sv',
      url: 'http://roberthonsby.com'
    )
  end

  subject(:tweet) do
    Tweet.new(
      tweeted_at: Time.now,
      full_text: 'New tweet!',
      url: 'https://twitter.com/foobar/status/123413132131',
      user_id: user.id
    )
  end

  it { should be_valid }
  it { should respond_to(:tweeted_at) }
  it { should respond_to(:full_text) }
  it { should respond_to(:url) }
  it { should belong_to(:user) }
end