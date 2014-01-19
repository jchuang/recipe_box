require 'spec_helper'

describe Tag do

  it { should validate_presence_of :name }

  it 'should validate uniqueness of name' do
    FactoryGirl.create(:tag)
    should validate_uniqueness_of(:name)
  end

  it { should have_many(:recipe_tags).dependent(:destroy) }
  it { should have_many(:recipes).through(:recipe_tags) }

  it { should belong_to :user }

end
