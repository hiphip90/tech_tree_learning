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
#  full_name         :string
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
  validates :full_name, uniqueness: { scope: :tree }
  validates :depth, :column_number, numericality: { greater_than_or_equal_to: 0 }
  has_attached_file :icon, styles: { normal: "64x64>" },
                           url: '/:class/:id/icon',
                           default_url: "/assets/missing.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/
  validate :requirement_present_in_tree
  validate :no_overlapping

  before_save :populate_name
  before_destroy :destroy_requirements

  protected

  def update_requirements(old_req, new_req)
    requirements.delete_if { |req| req == old_req }
    requirements << new_req
    save
  end

  private

  def destroy_requirements
    requirements.each do |node_name|
      tree.nodes.find_by(name: node_name).destroy
    end
  end

  def populate_name
    old_name = name
    new_name = full_name.downcase.gsub(' ', '')
    return if old_name == new_name
    self.name = new_name
    dependent_nodes = tree.nodes.where("'#{old_name}' = ANY requirements")
    dependent_nodes.each { |node| node.update_requirements(old_name, new_name) }
  end

  def requirement_present_in_tree
    requirements.reject! { |requirement| requirement.empty? }
    node_names = tree.nodes.pluck('name') - [name]
    valid = requirements.all? { |requirement| node_names.include?(requirement) }
    return true if valid
    errors.add(:requirements, 'not present in the tree')
  end

  def no_overlapping
    overlapping_node = tree.nodes.find_by(depth: depth, column_number: column_number)
    return true unless overlapping_node.present?
    errors.add(:base, 'overlaps with existing node')
  end
end
