class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :places, :slug
  end
end
