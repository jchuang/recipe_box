class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :username, null: false
      t.string :photo_path
      t.text :profile_notes
      t.datetime :last_signed_in

      t.timestamps
      t.index :username, unique: true
    end
  end
end
