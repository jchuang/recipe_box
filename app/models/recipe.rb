class Recipe < ActiveRecord::Base

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :directions, presence: true

  attr_accessor :time_number, :time_unit

  before_save :calculate_time, on: [:create, :update]

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
