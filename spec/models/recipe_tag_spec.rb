require 'spec_helper'

describe RecipeTag do

  it { should validate_presence_of :recipe }
  it { should validate_presence_of :tag }

  it 'should validate uniqueness of tags for a given recipe' do
    FactoryGirl.create(:recipe_tag)
    should validate_uniqueness_of(:recipe_id).scoped_to(:tag_id)
  end

  it { should belong_to :recipe }
  it { should belong_to :tag }

end
