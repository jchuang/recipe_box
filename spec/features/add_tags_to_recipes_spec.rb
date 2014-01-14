require 'spec_helper'

feature 'users can add tags to their recipes', %q{
  As a registered user
  I can add tags to my recipes
  So that I can find them easily
} do

# Acceptance Criteria:
# * when creating or editing a recipe, user can add an existing tag or create a new tag
# * creating a new tag happens in its own user interface
# * existing tags are easily accessed so user can maintain consistency

  scenario 'create a valid tag' do
    visit tags_path
    fill_in 'Name', with: 'vegetarian'
    click_on 'Add Tag'
    expect(page).to have_content 'vegetarian'
    expect(page).to have_content 'Your tag was successfully added.'
  end

  scenario 'invalid tag with no name' do
    visit tags_path
    click_on 'Add Tag'
    expect(page).to have_content 'The name must be provided. Please try again.'
    expect(page).to_not have_content 'Your tag was successfully added.'
  end

  scenario 'edit an existing tag' do
    tag = FactoryGirl.create(:tag, name: 'some tag')
    visit tags_path

    click_on 'Edit Tag'
    fill_in 'Name', with: 'another tag'
    click_on 'Update Tag'

    expect(page).to have_content 'another tag'
    expect(page).to_not have_content 'some tag'
  end

  scenario 'delete an existing tag' do
    tag1 = FactoryGirl.create(:tag)
    tag2 = FactoryGirl.create(:tag)
    visit tags_path

    click_on 'Delete Tag'
    expect(page).to have_content tag2.name
    expect(page).to_not have_content tag1.name
  end

  scenario 'add tags to a recipe'
  scenario 'remove tags from a recipe'
  scenario 'find all recipes that include a given tag'

end
