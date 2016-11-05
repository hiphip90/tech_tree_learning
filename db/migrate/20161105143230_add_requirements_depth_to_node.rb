class AddRequirementsDepthToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :requirements, :text, array: true, default: []
    add_column :nodes, :depth, :integer
  end
end
