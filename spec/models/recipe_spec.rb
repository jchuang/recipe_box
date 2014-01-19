require 'spec_helper'

describe Recipe do

  it { should validate_presence_of :name }
  it { should validate_presence_of :ingredients }
  it { should validate_presence_of :directions }

  it 'should validate uniqueness of name for a given user' do
    FactoryGirl.create(:recipe)
    should validate_uniqueness_of(:name).scoped_to(:user_id)
  end

  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:recipe_tags).dependent(:destroy) }
  it { should have_many(:tags).through(:recipe_tags) }
  it { should belong_to :user }

  describe '#calculate_time' do

    it 'sets the correct time when minutes are provided' do
      recipe = FactoryGirl.build(:recipe)
      recipe.time_number = '45'
      recipe.time_unit = 'minutes'

      recipe.save
      expect(recipe.time_in_minutes).to eq(45)
    end

    it 'sets the correct time when hours are provided' do
      recipe = FactoryGirl.build(:recipe)
      recipe.time_number = '1.5'
      recipe.time_unit = 'hours'

      recipe.save
      expect(recipe.time_in_minutes).to eq(90)
    end

  end
end
