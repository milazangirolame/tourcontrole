class AddImageBannerToTourStore < ActiveRecord::Migration[5.1]
  def change
    add_column :tour_stores, :image_banner, :string
  end
end
