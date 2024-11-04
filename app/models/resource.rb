class Resource < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  has_one_attached :file
end
