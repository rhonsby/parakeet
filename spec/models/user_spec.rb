require 'spec_helper'

describe User do
  subject(:user) do
   User.new(
      username: 'foobar',
      profile_image_url: 'http://bit.ly/19Mo8sv',
      url: 'http://roberthonsby.com')
  end

  it { should be_valid }
  it { should respond_to(:username) }
  it { should respond_to(:name) }
  it { should respond_to(:profile_image_url) }
  it { should respond_to(:url) }
end