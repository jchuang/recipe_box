require 'spec_helper'

feature 'search recipes based on keywords', %q{
  As a user
  I can search for recipes by keyword
  So I can use the ingredients I already have
} do

  # Acceptance Criteria:
  # * users can enter the text they would like to search for
  # * recipes containing that text in their name, ingredients, or directions are displayed
  # * if no recipes match, user is given some way to continue exploring recipes

  scenario 'matches single word in recipe name' do
    recipe = FactoryGirl.create(:recipe, name: 'ice cream sandwich')
    other_recipe = FactoryGirl.create(:recipe)

    visit recipes_path
    fill_in 'Keywords', with: 'sandwich'
    click_on 'Search Recipes'

    expect(page).to have_content recipe.name
    expect(page).to_not have_content other_recipe.name
  end

  scenario 'matches multiple words in recipe name' do
    recipe = FactoryGirl.create(:recipe, name: 'ice cream sandwich')
    other_recipe = FactoryGirl.create(:recipe)

    visit recipes_path
    fill_in 'Keywords', with: 'ice cream'
    click_on 'Search Recipes'

    expect(page).to have_content recipe.name
    expect(page).to_not have_content other_recipe.name
  end

  scenario 'matches text in ingredients' do
    recipe = FactoryGirl.create(:recipe, ingredients: 'lentils, tomatoes, kale, onions, carrots')
    other_recipe = FactoryGirl.create(:recipe)

    visit recipes_path
    fill_in 'Keywords', with: 'kale lentil'
    click_on 'Search Recipes'

    expect(page).to have_content recipe.name
    expect(page).to_not have_content other_recipe.name
  end

  scenario 'matches text in directions' do
    recipe = FactoryGirl.create(:recipe, directions: 'Add lentils to soup. Stir well.')
    other_recipe = FactoryGirl.create(:recipe)

    visit recipes_path
    fill_in 'Keywords', with: 'lentil soup'
    click_on 'Search Recipes'

    expect(page).to have_content recipe.name
    expect(page).to_not have_content other_recipe.name
  end
end
