# == Schema Information
#
# Table name: trees
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  icon_file_name    :string
#  icon_content_type :string
#  icon_file_size    :integer
#  icon_updated_at   :datetime
#

class Tree < ApplicationRecord
  has_many :nodes
  has_attached_file :icon, styles: { normal: "64x64>" },
                           url: '/:class/:id/icon',
                           default_url: "/assets/missing.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/
end
