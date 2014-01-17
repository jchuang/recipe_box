class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :password_digest, null: false

      t.timestamps
    end
  end
end
