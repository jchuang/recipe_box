require 'spec_helper'

feature 'find recipes by time required', %q{
  As a user
  I can search for recipes by time required
  So I can find a recipe that meets my needs
} do

  # Acceptance Criteria:
  # * users can enter a maximum time
  # * recipes that can be completed in that amount of time are displayed
  # * if no recipes are displayed, user is given some way to continue exploring recipes

  scenario 'displays time in the desired units' do
    recipe = FactoryGirl.create(:recipe)

    visit edit_recipe_path(recipe)
    fill_in 'Time', with: '90'
    select 'minutes', from: 'Unit'
    click_on 'Update Recipe'

    expect(page).to have_content 'Time: 90 minutes'

    click_on 'Edit Recipe'
    fill_in 'Time', with: '1.5'
    select 'hours', from: 'Unit'
    click_on 'Update Recipe'

    expect(page).to have_content 'Time: 1.5 hours'
  end

end
