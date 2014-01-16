require 'spec_helper'

describe Tag do

  it { should validate_presence_of :name }
  it { should validate_presence_of :user }

  it 'should validate uniqueness of tag name for a given user' do
    FactoryGirl.create(:tag)
    should validate_uniqueness_of(:name).scoped_to(:user_id)
  end

  it { should have_many(:recipe_tags).dependent(:destroy) }
  it { should have_many(:recipes).through(:recipe_tags) }
  it { should belong_to :user }

end
