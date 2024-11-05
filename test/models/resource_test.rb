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
require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
