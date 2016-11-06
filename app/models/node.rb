# == Schema Information
#
# Table name: nodes
#
#  id                :integer          not null, primary key
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  requirements      :text             default([]), is an Array
#  depth             :integer
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#  tree_id           :integer
#  column_number     :integer
#
# Indexes
#
#  index_nodes_on_tree_id  (tree_id)
#
# Foreign Keys
#
#  fk_rails_4161e18e83  (tree_id => trees.id)
#

class Node < ApplicationRecord
  belongs_to :tree

  validates :name, :depth, :column_number, presence: true
  validates :name, uniqueness: { scope: :tree }
  validates :depth, :column_number, numericality: { greater_than_or_equal_to: 0 }
  has_attached_file :icon, styles: { normal: "64x64>" },
                           url: '/:class/:id/icon',
                           default_url: "/assets/images/missing_icon.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/
  validate :requirement_present_in_tree

  private

  def requirement_present_in_tree
    node_names = tree.nodes.pluck('name') - [name]
    valid = requirements.all? { |requirement| node_names.include?(requirement) }
    errors.add(:requirements, 'not present in the tree') unless valid
  end
end
