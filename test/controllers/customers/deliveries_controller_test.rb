require 'test_helper'

class Customers::DeliveriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_deliveries_index_url
    assert_response :success
  end

  test "should get create" do
    get customers_deliveries_create_url
    assert_response :success
  end

  test "should get destroy" do
    get customers_deliveries_destroy_url
    assert_response :success
  end

  test "should get edit" do
    get customers_deliveries_edit_url
    assert_response :success
  end

  test "should get update" do
    get customers_deliveries_update_url
    assert_response :success
  end

end
