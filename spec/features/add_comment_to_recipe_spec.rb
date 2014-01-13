require 'spec_helper'

feature 'comment on recipe', %q{
  As a registered user
  I can add comments to a recipe
  So I can share my experiences with others
} do

# Acceptance Criteria:
# * users can comment on any recipe that they can view
# * once the comment is saved, anyone who can view the recipe can also see the comment
# * when viewing a recipe, user can show or hide comments
# * comments are shown in chronological order

  scenario 'add valid comment to recipe' do
    recipe = FactoryGirl.create(:recipe)
    visit recipe_path(recipe)

    fill_in 'Title', with: 'comment title'
    fill_in 'Comment Text', with: 'this was great!'
    click_on 'Add Comment'

    expect(page).to have_content 'Your comment was successfully added.'
    expect(page).to have_content recipe.name
    expect(page).to have_content 'comment title'
    expect(page).to have_content 'this was great!'
  end

  scenario 'add multiple comments to recipe' do
    recipe = FactoryGirl.create(:recipe)
    comment1 = FactoryGirl.create(:comment, title: 'this one has a title', recipe: recipe)
    comment2 = FactoryGirl.create(:comment, recipe: recipe)
    comment3 = FactoryGirl.create(:comment, recipe: recipe)

    visit recipe_path(recipe)
    expect(page).to have_content recipe.name
    expect(page).to have_content comment1.body
    expect(page).to have_content comment2.body
    expect(page).to have_content comment3.body
  end

  scenario 'invalid comment with no text' do
    recipe = FactoryGirl.create(:recipe)
    visit recipe_path(recipe)

    click_on 'Add Comment'
    expect(page).to have_content 'There was an issue with your comment. Please try again.'
    expect(page).to_not have_content 'Your comment was successfully added.'
  end

  scenario 'delete comment from recipe' do
    recipe = FactoryGirl.create(:recipe)
    comment = FactoryGirl.create(:comment, recipe: recipe, body: 'a special comment')
    visit recipe_path(recipe)

    click_on 'Delete Comment'
    expect(page).to have_content 'Your comment was successfully deleted.'
    expect(page).to_not have_content 'a special comment'
  end
end
