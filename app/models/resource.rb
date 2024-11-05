# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  description :string
#  kind        :string
#  name        :string
#  uri         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#
# Indexes
#
#  index_resources_on_category_id  (category_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
class Resource < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_one_attached :file
end
