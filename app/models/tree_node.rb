# == Schema Information
#
# Table name: tree_nodes
#
#  id         :integer          not null, primary key
#  tree_id    :integer
#  node_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tree_nodes_on_node_id  (node_id)
#  index_tree_nodes_on_tree_id  (tree_id)
#
# Foreign Keys
#
#  fk_rails_2b2374d0ac  (node_id => nodes.id)
#  fk_rails_e338eb9ddb  (tree_id => trees.id)
#

class TreeNode < ApplicationRecord
  belongs_to :tree
  belongs_to :node
end
