class AddUserIdsToIndexes < ActiveRecord::Migration
  def up
    remove_index :recipes, :name
    add_index :recipes, [:name, :user_id], unique: true

    remove_index :tags, :name
    add_index :tags, [:name, :user_id], unique: true
  end

  def down
    remove_index :recipes, [:name, :user_id]
    add_index :recipes, :name, unique: true

    remove_index :tags, [:name, :user_id]
    add_index :tags, :name, unique: true
  end
end
