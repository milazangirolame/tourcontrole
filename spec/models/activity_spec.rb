require 'rails_helper'

RSpec.describe Activity, type: :model do
  it 'Checking latitude and longitude' do
    activity = create(:activity)
    activity.geocode
    expect(activity.latitude && activity.longitude).to be_kind_of Float
  end
end
