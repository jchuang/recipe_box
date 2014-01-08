require 'spec_helper'

describe Recipe do

  it { should validate_presence_of :name }
  it { should validate_presence_of :ingredients }
  it { should validate_presence_of :directions }

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
