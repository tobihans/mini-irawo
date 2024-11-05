# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  description :string
#  kind        :string
#  name        :string
#  url         :string
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

  VALID_KINDS = %w[url file]

  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :image, presence: true

  validates :kind, inclusion: { in: VALID_KINDS }
  validates :description, presence: true, length: { minimum: 75 }

  with_options if: :external? do
    validates :url, presence: true, url: true
    validates :file, absence: true
  end

  with_options if: :internal? do
    validates :file, presence: true
    validates :url, absence: true
  end

  def external?
    kind == VALID_KINDS.first
  end

  def internal?
    kind == VALID_KINDS.last
  end
end
