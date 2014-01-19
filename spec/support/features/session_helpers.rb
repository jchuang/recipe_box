module Features
  module SessionHelpers
    def sign_up_with(email, password)
      visit sign_up_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Sign up'
    end

    def sign_in
      user = FactoryGirl.create(:user)
      visit root_path
      click_on 'Sign In'

      fill_in 'Email Address', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'
    end

    def create_recipe(recipe)
      visit new_recipe_path

      fill_in 'Name', with: recipe.name
      fill_in 'Ingredients', with: recipe.ingredients
      fill_in 'Directions', with: recipe.directions
      click_on 'Create Recipe'
    end
  end
end