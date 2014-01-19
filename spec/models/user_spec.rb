require 'spec_helper'

describe User do

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :username }

  it { should have_valid(:email).when('hello@csail.mit.edu', 'hello@gmail.com') }
  it { should_not have_valid(:email).when('email', 'hello@gmail', 'gmail.com') }

  it { should have_valid(:username).when('j_chuang') }
  it { should_not have_valid(:username).when('a', 'user name', 'hello*world') }

  it 'has a password confirmation that matches the password' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'other'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  it 'has a unique username' do
    FactoryGirl.create(:user)
    should validate_uniqueness_of(:username)
  end

  it { should have_many(:recipes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:tags).dependent(:destroy) }

end
