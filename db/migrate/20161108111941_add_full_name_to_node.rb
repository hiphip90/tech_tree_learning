class AddFullNameToNode < ActiveRecord::Migration[5.0]
  def change
    add_column :nodes, :full_name, :string
  end
end
