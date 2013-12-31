class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :time_in_minutes
      t.string :servings
      t.text :ingredients, null: false
      t.text :directions, null: false
      t.text :notes
      t.string :visibility, null: false, default: 'Public'

      t.index :name, unique: true

      t.timestamps
    end
  end
end
