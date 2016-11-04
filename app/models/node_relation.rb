# == Schema Information
#
# Table name: node_relations
#
#  id             :integer          not null, primary key
#  slave_node_id  :integer
#  master_node_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_node_relations_on_master_node_id  (master_node_id)
#  index_node_relations_on_slave_node_id   (slave_node_id)
#

class NodeRelation < ApplicationRecord
  belongs_to :slave_node, class_name: 'Node'
  belongs_to :master_node, class_name: 'Node'
end
