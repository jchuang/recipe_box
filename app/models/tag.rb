class Tag < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :recipe_tags, inverse_of: :tag, dependent: :destroy
  has_many :recipes, through: :recipe_tags
  belongs_to :user, inverse_of: :tags

end
