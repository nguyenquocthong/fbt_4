class CreateCommentHierarchies < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_hierarchies do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end
  end
end
