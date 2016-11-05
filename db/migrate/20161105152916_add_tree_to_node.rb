class AddTreeToNode < ActiveRecord::Migration[5.0]
  def change
    add_reference :nodes, :tree, foreign_key: true
  end
end
