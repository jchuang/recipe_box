class RecipeTag < ActiveRecord::Base

  validates :recipe, presence: true
  validates :tag, presence: true
  validates :recipe_id, uniqueness: { scope: :tag_id }

  belongs_to :recipe, inverse_of: :recipe_tags
  belongs_to :tag, inverse_of: :recipe_tags

end
