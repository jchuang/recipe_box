class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :recipe_id, null: false

      t.timestamps
      t.index :recipe_id
    end
  end
end
