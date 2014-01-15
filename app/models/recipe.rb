class Recipe < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :ingredients, presence: true
  validates :directions, presence: true

  has_many :comments, inverse_of: :recipe, dependent: :destroy
  has_many :recipe_tags, inverse_of: :recipe, dependent: :destroy
  has_many :tags, through: :recipe_tags

  before_save :calculate_time

  def self.maximum_time(minutes)
    Recipe.where("time_in_minutes <= ?", minutes).where("time_in_minutes IS NOT NULL")
  end

  def self.search_text(keywords)
    Recipe.where("to_tsvector(name || ' ' || ingredients || ' ' || directions) @@ plainto_tsquery(?)", keywords)
  end

  private

  def calculate_time
    unless time_number.blank?

      case time_unit
      when 'minutes'
        self.time_in_minutes = time_number.to_i
      when 'hours'
        self.time_in_minutes = (time_number.to_f * 60).round
      end
    end
  end
end
