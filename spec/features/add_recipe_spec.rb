require 'spec_helper'

feature 'user adds recipe', %q{
  As a registered user
  I can add recipes to my collection
  So I can access all my favorites in one place
} do

# Acceptance Criteria:
# * registered users can select an "add recipe" option
# * to add a recipe, user must provide a name, ingredients, and directions
# * optionally, user can provide notes, time required, and number of servings
# * if all required fields have been entered, recipe is saved successfully
# * otherwise user is prompted to enter remaining required fields

  scenario 'create a valid recipe' do
    sign_in
    visit new_recipe_path

    fill_in 'Name', with: 'Green Eggs and Ham'
    fill_in 'Ingredients', with: %q{
      4 green eggs
      1/2 lb ham
    }
    fill_in 'Directions', with: %q{
      1. Cook the eggs.
      2. Cook the ham.
      3. Combine.
    }

    fill_in 'Notes', with: 'Inspired by Dr. Seuss'
    fill_in 'Time', with: '5 minutes'
    fill_in 'Servings', with: '2'

    click_on 'Create Recipe'
    expect(page).to have_content 'Recipe was successfully added.'
    expect(page).to have_content 'Green Eggs and Ham'
  end

  scenario 'create a duplicate recipe' do
    sign_in
    recipe = FactoryGirl.build(:recipe)
    create_recipe(recipe)
    visit new_recipe_path

    fill_in 'Name', with: recipe.name
    fill_in 'Ingredients', with: recipe.ingredients
    fill_in 'Directions', with: recipe.directions
    click_on 'Create Recipe'

    expect(page).to have_content 'Name has already been taken'
    expect(page).to_not have_content 'Recipe was successfully added.'
  end

  scenario 'required information is not provided' do
    sign_in
    visit new_recipe_path
    click_on 'Create Recipe'

    expect(page).to_not have_content 'Recipe was successfully added.'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Ingredients can't be blank"
    expect(page).to have_content "Directions can't be blank"
  end

  scenario 'add a recipe without some optional fields' do
    sign_in
    recipe = FactoryGirl.build(:recipe)
    visit new_recipe_path

    fill_in 'Name', with: recipe.name
    fill_in 'Ingredients', with: recipe.ingredients
    fill_in 'Directions', with: recipe.directions
    fill_in 'Servings', with: '4'

    click_on 'Create Recipe'

    expect(page).to have_content 'Servings'
    expect(page).to_not have_content 'Time'
    expect(page).to_not have_content 'Notes'
  end

  scenario 'when user is not authenticated' do
    visit recipes_path
    expect(page).to_not have_content 'Add New Recipe'
    expect { visit new_recipe_path }.to raise_error(ActionController::RoutingError,
      'The page you requested was not found.')
  end
end
