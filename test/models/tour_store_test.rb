require 'test_helper'

class TourStoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Creating a new store' do
    store = tour_stores(:store)
    assert_equal 'tourcontrole.com', store.website, ['Should bring up the tourcontrole.com website']
  end
end
