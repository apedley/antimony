class AddPublicToGalleriesAndPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :public, :boolean
    add_column :galleries, :public, :boolean
  end
end
