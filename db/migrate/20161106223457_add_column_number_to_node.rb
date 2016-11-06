class AddColumnNumberToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :column_number, :integer
  end
end
