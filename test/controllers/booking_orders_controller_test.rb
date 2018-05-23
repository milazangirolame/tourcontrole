require 'test_helper'

class BookingOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get booking_orders_index_url
    assert_response :success
  end

  test "should get show" do
    get booking_orders_show_url
    assert_response :success
  end

  test "should get new" do
    get booking_orders_new_url
    assert_response :success
  end

  test "should get edit" do
    get booking_orders_edit_url
    assert_response :success
  end

end
