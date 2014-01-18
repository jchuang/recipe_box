require 'spec_helper'

feature 'registered user signs in', %q{
  As a registered user
  I can sign in to my account
  So that I can add and share recipes
} do

# Acceptance Criteria:
# * if user wants to log in, they are asked to enter a username and password
# * if the username exists and the password is correct, user is granted access to site
# * if the username exists but the password is incorrect, user is prompted to enter password again
# * if the username does not exist, user is prompted to re-enter information or sign up

  scenario 'registered user provides correct email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on 'Sign In'

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Welcome back!'
    expect(page).to have_content 'Sign Out'
  end

end
