class AddIconToTree < ActiveRecord::Migration[5.0]
  def change
    add_attachment :trees, :icon
  end
end
