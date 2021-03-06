class Recipe < ActiveRecord::Base

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :ingredients, presence: true
  validates :directions, presence: true

  has_many :comments, inverse_of: :recipe, dependent: :destroy
  has_many :recipe_tags, inverse_of: :recipe, dependent: :destroy
  has_many :tags, through: :recipe_tags
  belongs_to :user, inverse_of: :recipes

  before_save :calculate_time

  def self.maximum_time(minutes)
    Recipe.where("time_in_minutes <= ?", minutes).where("time_in_minutes IS NOT NULL")
  end

  def self.search_text(keywords)
    Recipe.where("to_tsvector(name || ' ' || ingredients || ' ' || directions) @@ plainto_tsquery(?)", keywords)
  end

  def self.filter_recipes(params)
    recipes = Recipe.all
    if params[:minutes].present?
      recipes = recipes.maximum_time(params[:minutes].to_i)
    end
    if params[:keywords].present?
      recipes = recipes.search_text(params[:keywords])
    end
    recipes
  end

  private

  def calculate_time
    if time_number.blank?
      self.time_in_minutes = nil
    else
      case time_unit
      when 'minutes'
        self.time_in_minutes = time_number.to_i
      when 'hours'
        self.time_in_minutes = (time_number.to_f * 60).round
      end
    end
  end
end
