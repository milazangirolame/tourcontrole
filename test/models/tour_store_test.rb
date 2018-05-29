require 'test_helper'

class TourStoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Creating a new store' do
    store = TourStore.new(website: 'tourcontrole.com')
    assert_equal 'tourcontrole.com', store.website
  end
end
