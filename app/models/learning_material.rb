# == Schema Information
#
# Table name: learning_materials
#
#  id          :integer          not null, primary key
#  node_id     :integer
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_learning_materials_on_node_id  (node_id)
#
# Foreign Keys
#
#  fk_rails_a3ad2086f4  (node_id => nodes.id)
#

class LearningMaterial < ApplicationRecord
  belongs_to :node

  validates :name, presence: true
end
