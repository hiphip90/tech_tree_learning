class AddCompletedToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :completed, :boolean, default: false, null: false
  end
end
