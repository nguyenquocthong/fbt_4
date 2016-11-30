class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :gravatar
      t.integer :role, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :users, :deleted_at
  end
end
