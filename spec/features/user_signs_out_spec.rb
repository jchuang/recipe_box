require 'spec_helper'

feature 'authenticated user signs out', %q{
  As an authenticated user
  I can sign out of my account
  So that I can protect my information
} do

  scenario 'successful sign out' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'

    expect(page).to have_content 'Sign Out'
    click_on 'Sign Out'

    expect(page).to_not have_content 'Sign Out'
    expect(page).to have_content 'You have successfully signed out.'
  end

end
