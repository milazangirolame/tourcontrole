class AddSocialMediaLinksToTourStores < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :instagram_link, :string
    add_column :tour_stores, :facebook_link, :string
    add_column :tour_stores, :trip_advisor_ling, :string
    add_column :tour_stores, :twitter_link, :string
  end
end
