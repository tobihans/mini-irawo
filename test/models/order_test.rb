# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resource_id :integer          not null
#  user_id     :integer
#
# Indexes
#
#  index_orders_on_resource_id  (resource_id)
#  index_orders_on_user_id      (user_id)
#
# Foreign Keys
#
#  resource_id  (resource_id => resources.id)
#  user_id      (user_id => users.id)
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
