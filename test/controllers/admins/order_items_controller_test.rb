require 'test_helper'

class Admins::OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admins_order_items_update_url
    assert_response :success
  end

end
