class Recipe < ActiveRecord::Base

  validates :name, presence: true
  validates :ingredients, presence: true
  validates :directions, presence: true

  before_save :calculate_time

  def time_number=(value)
    @time_number = value
  end

  def time_number
    @time_number ||= time_in_minutes
  end

  def time_unit=(value)
    @time_unit = value
  end

  def time_unit
    @time_unit ||= "minutes"
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
