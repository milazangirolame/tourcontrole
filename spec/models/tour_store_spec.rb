require 'rails_helper'

RSpec.describe TourStore, type: :model do
  it 'testing owner name' do
    user = build(:user, first_name: 'oscar')
    store = create(:tour_store, user: user)
    expect(store.user.first_name).to eq('oscar')
  end
end
