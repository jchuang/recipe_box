class Recipe < ActiveRecord::Base

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :directions, presence: true

end
