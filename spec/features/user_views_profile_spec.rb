require 'spec_helper'

feature 'user profiles and related navigation', %q{
  As a user
  I can view and navigate to other users' profiles
  So that I can more easily explore their content
} do

# Acceptance Criteria:
# * Each recipe, comment, and tag is clearly labeled with the user who created it
# * The username links to that user's profile page
# * Profile pages contain links to the user's recipes and tags

  scenario 'each piece of content is labeled with username' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    recipe = FactoryGirl.create(:recipe, user: user1)
    tag = FactoryGirl.create(:tag, user: user1)

    sign_in_user(user2)
    visit user_recipes_path(user1)
    expect(page).to have_content user1.username
    visit recipe_path(recipe)
    expect(page).to have_content user1.username

    comment = FactoryGirl.build(:comment)
    add_comment(comment, recipe)
    expect(page).to have_content user2.username

    visit user_tags_path(user1)
    expect(page).to have_content user1.username
    visit tag_path(tag)
    expect(page).to have_content user1.username
  end

  scenario 'user profile links to recipes and tags for that user' do
    user = FactoryGirl.create(:user)
    recipe = FactoryGirl.create(:recipe, user: user)
    tag = FactoryGirl.create(:tag, user: user)

    visit user_path(user)
    click_on "See #{ user.username }'s Recipes"
    expect(page).to have_content recipe.name

    visit user_path(user)
    click_on "See #{ user.username }'s Tags"
    expect(page).to have_content tag.name
  end

end
