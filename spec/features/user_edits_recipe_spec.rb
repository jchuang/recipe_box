require 'spec_helper'

feature 'user edits recipe', %q{
  As a registered user
  I can edit recipes in my collection
  So I can build on past experiences
  } do

# Acceptance Criteria:
# * when user is viewing one of their recipes, they can select an "edit recipe" option
# * user can edit contents of any field, including adding content to optional fields
# * if all required fields have been entered, user can choose to save the updated recipe

  scenario 'desired edits include all required fields' do
    recipe = FactoryGirl.create(:recipe)

    visit recipe_path(recipe)
    click_on 'Edit Recipe'

    fill_in 'Name', with: 'delicious foods'
    fill_in 'Ingredients', with: 'chocolate stout, vanilla ice cream'
    fill_in 'Directions', with: 'combine and enjoy'
    fill_in 'Notes', with: 'Night Shift and Southern Tier are both delicious.'
    fill_in 'Time', with: '5 minutes'
    fill_in 'Servings', with: 'many'

    click_on 'Update Recipe'
    expect(page).to have_content 'Recipe was successfully updated.'
    expect(page).to have_content 'chocolate stout'
  end

  scenario 'a required field is empty' do
    recipe = FactoryGirl.create(:recipe)

    visit recipe_path(recipe)
    click_on 'Edit Recipe'

    fill_in 'Name', with: ''
    fill_in 'Ingredients', with: ''
    fill_in 'Directions', with: ''
    click_on 'Update Recipe'

    expect(page).to_not have_content 'Recipe was successfully updated.'
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Ingredients can't be blank"
    expect(page).to have_content "Directions can't be blank"
  end

end
