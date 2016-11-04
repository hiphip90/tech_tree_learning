# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Node < ApplicationRecord
  has_many :tree_nodes
  has_many :trees, through: :tree_nodes
  has_many :node_relations_as_slave, class_name: 'NodeRelation',
                                     foreign_key: :slave_node_id
  has_many :node_relations_as_master, class_name: 'NodeRelation',
                                      foreign_key: :master_node_id
  has_many :slave_nodes, through: :node_relations_as_master
  has_many :master_nodes, through: :node_relations_as_slave
end
