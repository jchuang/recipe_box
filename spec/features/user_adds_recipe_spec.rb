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
    visit 'recipes/new'

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

  scenario 'required information is not provided' do
    visit 'recipes/new'
    click_on 'Create Recipe'

    expect(page).to_not have_content 'Recipe was successfully added.'

    within ".input.recipe_name" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.recipe_ingredients" do
      expect(page).to have_content "can't be blank"
    end
    within ".input.recipe_directions" do
      expect(page).to have_content "can't be blank"
    end
  end

  scenario 'Save a recipe without some optional fields' do
    recipe = FactoryGirl.build(:recipe)

    visit 'recipes/new'

    fill_in 'Name', with: recipe.name
    fill_in 'Ingredients', with: recipe.ingredients
    fill_in 'Directions', with: recipe.directions
    fill_in 'Servings', with: '4'

    click_on 'Create Recipe'

    expect(page).to have_content 'Servings'
    expect(page).to_not have_content 'Time'
    expect(page).to_not have_content 'Notes'
  end

end
