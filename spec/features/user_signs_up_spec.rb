require 'spec_helper'

feature 'user signs up for an account', %q{
  As a unregistered user
  I can create an account
  So that I can begin to add recipes
} do

# Acceptance Criteria:
# * any user can access a section where they can either log in or create an account
# * if user wants to create an account, they are asked to enter their first name, last name, password, and email address
# * user must re-enter password to confirm

  scenario 'all required information is provided' do
    visit root_path
    click_on 'Create New Account'

    fill_in 'First Name', with: 'Hello'
    fill_in 'Last Name', with: 'World'
    fill_in 'Email Address', with: 'abc@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password Confirmation', with: 'password'

    click_on 'Create Account'
    expect(page).to have_content 'Welcome to RecipeBox!'
    expect(page).to have_content 'Sign Out'
  end



end
