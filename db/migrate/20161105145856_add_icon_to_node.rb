class AddIconToNode < ActiveRecord::Migration[5.0]
  def change
    add_attachment :nodes, :icon
  end
end
