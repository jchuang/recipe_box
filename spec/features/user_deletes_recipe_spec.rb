require 'spec_helper'

feature 'user deletes recipe', %q{
  As a registered user
  I can delete recipes I have created
  So I can curate my collection
  } do

# Acceptance Criteria:
# * when user is viewing one of their recipes, they can select a "delete recipe" option
# * when user is viewing someone else's recipe, there is no delete option

  scenario 'when recipe belongs to user' do
    sign_in
    recipe = FactoryGirl.build(:recipe)
    create_recipe(recipe)
    expect(page).to have_content 'tasty food'

    click_on 'Delete Recipe'
    expect(page).to have_content 'Recipe was successfully deleted.'
    expect(page).to_not have_content 'tasty food'
  end

  scenario 'when recipe belongs to another user' do
    recipe = FactoryGirl.create(:recipe)
    sign_in
    visit recipe_path(recipe)
    expect(page).to_not have_content 'Delete Recipe'
  end

  scenario 'when user is not authenticated' do
    recipe = FactoryGirl.create(:recipe)
    visit recipe_path(recipe)
    expect(page).to_not have_content 'Delete Recipe'
  end
end
