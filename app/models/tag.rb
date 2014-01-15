class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :recipe_tags, inverse_of: :tag, dependent: :destroy
  has_many :recipes, through: :recipe_tags

end
