require 'spec_helper'

feature 'user adds tags to recipes', %q{
  As a registered user
  I can add tags to my recipes
  So that I can find them easily
} do

# Acceptance Criteria:
# * when creating or editing a recipe, user can add an existing tag or create a new tag
# * creating a new tag happens in its own user interface
# * existing tags are easily accessed so user can maintain consistency

  context 'user manages their own tags' do
    scenario 'create a valid tag' do
      sign_in
      click_on 'My Tags'
      fill_in 'Name', with: 'vegetarian'
      click_on 'Add Tag'

      expect(page).to have_content 'vegetarian'
      expect(page).to have_content 'Your tag was successfully added.'
    end

    scenario 'invalid tag with no name' do
      sign_in
      click_on 'My Tags'
      click_on 'Add Tag'

      expect(page).to have_content 'There was an issue with your tag. Please try again.'
      expect(page).to_not have_content 'Your tag was successfully added.'
    end

    scenario 'edit an existing tag' do
      sign_in
      tag = FactoryGirl.build(:tag, name: 'some tag')
      add_tag(tag)

      click_on 'Edit Tag'
      fill_in 'Name', with: 'another tag'
      click_on 'Update Tag'

      expect(page).to have_content 'another tag'
      expect(page).to_not have_content 'some tag'
    end

    scenario 'delete an existing tag' do
      sign_in
      tag = FactoryGirl.build(:tag)
      add_tag(tag)

      click_on 'Delete Tag'
      expect(page).to_not have_content tag.name
    end
  end

  scenario 'when tag belongs to another user' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    tag1 = FactoryGirl.create(:tag, user: user1)
    tag2 = FactoryGirl.create(:tag, user: user2)
    sign_in_user(user2)

    visit user_tags_path(user1)
    expect(page).to have_content tag1.name
    expect(page).to_not have_content tag2.name
    expect(page).to_not have_content 'Edit Tag'
    expect { visit edit_tag_path(tag1) }.to raise_error(ActionController::RoutingError,
      'The page you requested was not found.')

    expect(page).to_not have_content 'Delete Tag'
    expect(page).to_not have_content 'New Tag'

    visit user_tags_path(user2)
    expect(page).to have_content tag2.name
    expect(page).to_not have_content tag1.name
    expect(page).to have_content 'Edit Tag'
    expect(page).to have_content 'Delete Tag'
    expect(page).to have_content 'New Tag'
  end

  scenario 'when user is not authenticated' do
    user = FactoryGirl.create(:user)
    tag = FactoryGirl.create(:tag, user: user)

    visit user_tags_path(user)
    expect(page).to have_content tag.name
    expect(page).to_not have_content 'Edit Tag'
    expect(page).to_not have_content 'Delete Tag'
    expect(page).to_not have_content 'New Tag'
  end

  context 'editing a recipe' do
    before(:each) do
      sign_in
      tag1 = FactoryGirl.build(:tag, name: 'vegetarian')
      tag2 = FactoryGirl.build(:tag, name: 'Thanksgiving')
      add_tag(tag1)
      add_tag(tag2)
    end

    scenario 'add tags to recipe' do
      recipe = FactoryGirl.build(:recipe)
      create_recipe(recipe)

      click_on 'Edit Recipe'
      check 'vegetarian'
      click_on 'Update Recipe'

      expect(page).to have_content 'vegetarian'
      expect(page).to_not have_content 'Thanksgiving'
    end

    scenario 'remove tags from recipe' do
      recipe = FactoryGirl.build(:recipe)
      create_recipe(recipe)

      click_on 'Edit Recipe'
      check 'vegetarian'
      check 'Thanksgiving'
      click_on 'Update Recipe'

      click_on 'Edit Recipe'
      uncheck 'vegetarian'
      uncheck 'Thanksgiving'
      click_on 'Update Recipe'

      expect(page).to_not have_content 'vegetarian'
      expect(page).to_not have_content 'Thanksgiving'
    end
  end

  scenario 'find all recipes that include a given tag' do
    recipe1 = FactoryGirl.create(:recipe)
    recipe2 = FactoryGirl.create(:recipe)

    tag = FactoryGirl.create(:tag)
    tag.recipe_ids = [recipe1.id, recipe2.id]

    visit tag_path(tag)
    expect(page).to have_content recipe1.name
    expect(page).to have_content recipe2.name
  end
end
