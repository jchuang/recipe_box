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

  scenario 'displays recipes that meet time requirement' do
    FactoryGirl.create(:recipe, :fast)
    FactoryGirl.create(:recipe, :medium)
    FactoryGirl.create(:recipe, :slow)

    visit recipes_path
    fill_in 'minutes', with: '45'
    click_on 'Filter Recipes'

    expect(page).to have_content 'fast recipe'
    expect(page).to have_content 'medium recipe'
    expect(page).to_not have_content 'slow recipe'
  end

  scenario 'does not display recipes where no time is provided' do
    untimed = FactoryGirl.create(:recipe)
    fast = FactoryGirl.create(:recipe, :fast)

    visit recipes_path
    fill_in 'minutes', with: '45'
    click_on 'Filter Recipes'

    expect(page).to have_content fast.name
    expect(page).to_not have_content untimed.name
  end
end
