class CreateNodeRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :node_relations do |t|
      t.integer :slave_node_id, foreign_key: true
      t.integer :master_node_id, foreign_key: true

      t.index :slave_node_id
      t.index :master_node_id

      t.timestamps
    end
  end
end
