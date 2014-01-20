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
    sign_in
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
    sign_in
    visit recipe_path(recipe)

    comments = FactoryGirl.build_list(:comment, 3)
    comments.each do |comment|
      add_comment(comment, recipe)
    end

    expect(page).to have_content recipe.name
    comments.each do |comment|
      expect(page).to have_content comment.body
    end
  end

  scenario 'invalid comment with no text' do
    recipe = FactoryGirl.create(:recipe)
    sign_in
    visit recipe_path(recipe)

    click_on 'Add Comment'
    expect(page).to have_content 'There was an issue with your comment. Please try again.'
    expect(page).to_not have_content 'Your comment was successfully added.'
  end

  scenario 'delete comment from recipe' do
    recipe = FactoryGirl.create(:recipe)
    sign_in
    visit recipe_path(recipe)

    comment = FactoryGirl.build(:comment, recipe: recipe, body: 'a special comment')
    add_comment(comment, recipe)

    click_on 'Delete Comment'
    expect(page).to have_content 'Your comment was successfully deleted.'
    expect(page).to_not have_content 'a special comment'
  end

  scenario 'edit comment on recipe' do
    recipe = FactoryGirl.create(:recipe)
    sign_in
    visit recipe_path(recipe)

    comment = FactoryGirl.build(:comment, recipe: recipe, body: 'a special comment')
    add_comment(comment, recipe)

    click_on 'Edit Comment'
    fill_in 'Comment Text', with: 'just another comment'
    click_on 'Update Comment'

    expect(page).to have_content 'just another comment'
    expect(page).to_not have_content 'a special comment'
  end

  scenario 'when comment belongs to another user' do
    recipe = FactoryGirl.create(:recipe)
    comment = FactoryGirl.create(:comment, recipe: recipe)
    sign_in

    visit recipe_path(recipe)
    expect(page).to_not have_content 'Edit Comment'
    expect(page).to_not have_content 'Delete Comment'
    expect { visit edit_comment_path(comment) }.to raise_error(ActionController::RoutingError,
      'The page you requested was not found.')
  end

  context 'when user is not authenticated' do
    scenario 'the user cannot edit or delete comments' do
      recipe = FactoryGirl.create(:recipe)
      comment = FactoryGirl.create(:comment, recipe: recipe)

      visit recipe_path(recipe)
      expect(page).to_not have_content 'Edit Comment'
      expect(page).to_not have_content 'Delete Comment'
      expect { visit edit_comment_path(comment) }.to raise_error(ActionController::RoutingError,
        'The page you requested was not found.')
    end

    scenario 'the user cannot add comments' do
      recipe = FactoryGirl.create(:recipe)
      visit recipe_path(recipe)

      expect(page).to_not have_content 'New Comment'
      expect(page).to_not have_content 'Comment Text'
    end
  end
end
