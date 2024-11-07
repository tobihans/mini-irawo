# == Schema Information
#
# Table name: resources
#
#  id          :integer          not null, primary key
#  description :string
#  kind        :string
#  name        :string
#  price       :integer
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
  has_one_attached :image do |image|
    image.variant :thumb, resize_to_limit: [ 400, 400 ], gaussblur: 2, preprocessed: true
    image.variant :history_thumb, resize_to_limit: [ 175, 175 ], preprocessed: true
  end
  has_one_attached :file
  has_many :orders, dependent: :destroy

  scope :by_pricing, ->(pricing) {
          if pricing.present?
            case pricing
            when "free"
              where("price = 0")
            when "paid"
              where("price > 0")
            end
          end
        }
  scope :by_category, ->(category_id) { where(category_id: category_id) if category_id.present? }

  VALID_KINDS = %w[url file]

  validates :name, presence: true, length: { minimum: 5, maximum: 255 }
  validates :image, presence: true

  validates :kind, inclusion: { in: VALID_KINDS }
  validates :price, presence: true, comparison: { greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { minimum: 75 }

  with_options if: :external? do
    validates :url, presence: true, url: true
    validates :file, absence: true, on: :create
  end

  with_options if: :internal? do
    validates :file, presence: true
    validates :url, absence: true, on: :create
  end

  def external?
    kind == VALID_KINDS.first
  end

  def internal?
    kind == VALID_KINDS.last
  end
end
