class CreateTours < ActiveRecord::Migration[5.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.text :description
      t.text :schedule
      t.datetime :start_day
      t.integer :time_tour
      t.attachment :image
      t.integer :is_active, default: 0
      t.integer :price
      t.float :rate_avg
      t.string :slug

      t.references :place
      t.references :discount

      t.timestamps
    end
    add_index :tours, :slug
  end
end
