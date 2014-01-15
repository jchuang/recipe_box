class CreateRecipeTags < ActiveRecord::Migration
  def change
    create_table :recipe_tags do |t|
      t.integer :recipe_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
      t.index [:recipe_id, :tag_id], unique: true
    end
  end
end
