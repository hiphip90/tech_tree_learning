class CreateTreeNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :tree_nodes do |t|
      t.references :tree, foreign_key: true
      t.references :node, foreign_key: true

      t.timestamps
    end
  end
end
