class RecipeTag < ActiveRecord::Base

  validates :recipe, presence: true
  validates :tag, presence: true

  belongs_to :recipe, inverse_of: :recipe_tags
  belongs_to :tag, inverse_of: :recipe_tags

end
