require 'spec_helper'

describe User do

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :username }

  it 'does not allow repeated usernames' do
    FactoryGirl.create(:user)
    should validate_uniqueness_of :username
  end

  it { should have_many(:recipes).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:tags).dependent(:destroy) }

end
