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
    recipe = FactoryGirl.create(:recipe)
    visit recipes_path
    expect(page).to have_content 'tasty food'

    click_on 'Delete Recipe'
    expect(page).to have_content 'Recipe was successfully deleted.'
    expect(page).to_not have_content 'tasty food'
  end

  scenario 'when recipe belongs to another user'
end
