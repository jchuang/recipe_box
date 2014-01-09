class AddTimeNumberAndUnitToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :time_number, :string
    add_column :recipes, :time_unit, :string
  end
end
