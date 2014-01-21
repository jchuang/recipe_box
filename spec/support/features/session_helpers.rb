module Features
  module SessionHelpers

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

    def add_comment(comment, recipe)
      visit recipe_path(recipe)
      fill_in 'Comment Text', with: comment.body
      click_on 'Add Comment'
    end

    def add_tag(tag)
      click_on 'My Tags'
      fill_in 'Name', with: tag.name
      click_on 'Add Tag'
    end

    def sign_in_user(user)
      visit root_path
      click_on 'Sign In'

      fill_in 'Email Address', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign In'
    end

  end
end
