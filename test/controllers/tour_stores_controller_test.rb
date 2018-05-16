require 'test_helper'

class TourStoresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get tour_stores_new_url
    assert_response :success
  end

  test "should get edit" do
    get tour_stores_edit_url
    assert_response :success
  end

  test "should get index" do
    get tour_stores_index_url
    assert_response :success
  end

  test "should get show" do
    get tour_stores_show_url
    assert_response :success
  end

end
