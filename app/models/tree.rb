# == Schema Information
#
# Table name: trees
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tree < ApplicationRecord
  has_many :tree_nodes
  has_many :nodes, through: :tree_nodes
end
