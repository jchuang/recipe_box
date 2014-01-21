require 'spec_helper'

feature 'view recipes of other users', %q{
  As an authenticated user
  I know that others cannot edit and delete my recipes
  So that my information can be persisted
} do

  scenario 'all recipes are displayed on overall index page' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    recipe1 = FactoryGirl.create(:recipe, user: user1)
    recipe2 = FactoryGirl.create(:recipe, user: user2)

    visit recipes_path
    expect(page).to have_content recipe1.name
    expect(page).to have_content recipe2.name
  end

  scenario 'correct recipes are displayed on index page for each user' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    recipe1 = FactoryGirl.create(:recipe, user: user1)
    recipe2 = FactoryGirl.create(:recipe, user: user2)

    visit user_recipes_path(user1)
    expect(page).to have_content recipe1.name
    expect(page).to_not have_content recipe2.name

    visit user_recipes_path(user2)
    expect(page).to have_content recipe2.name
    expect(page).to_not have_content recipe1.name
  end
end
