class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.integer :user_id, null: false

      t.timestamps
      t.index :user_id
    end
  end
end
