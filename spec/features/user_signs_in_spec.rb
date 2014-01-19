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

  scenario 'email and password are not associated with an account' do
    visit root_path
    click_on 'Sign In'

    fill_in 'Email Address', with: 'email@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to_not have_content 'Welcome back!'
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'existing email but incorrect password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_on 'Sign In'

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: "#{user.password}abc"
    click_button 'Sign In'

    expect(page).to have_content 'Incorrect password, please try again.'
    expect(page).to_not have_content 'Welcome back!'
    expect(page).to_not have_content 'Sign Out'
  end

  scenario 'authenticated user cannot sign in again' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Sign Out'
    expect(page).to_not have_content 'Sign In'

    visit new_user_session_path
    expect(page).to have_content 'You are already signed in.'
  end
end
