class AddUserIdsToRecipesTagsComments < ActiveRecord::Migration
  def change
    add_column :recipes, :user_id, :integer, null: false
    add_index :recipes, :user_id

    add_column :tags, :user_id, :integer, null: false
    add_index :tags, :user_id

    add_column :comments, :user_id, :integer, null: false
  end
end
