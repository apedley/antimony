class CreatePhotosGalleriesTable < ActiveRecord::Migration
  def up
    create_table :galleries_photos, :id => false do |t|
      t.references :photo
      t.references :gallery
    end
    add_index :galleries_photos, [:photo_id, :gallery_id]
    add_index :galleries_photos, [:gallery_id, :photo_id]
  end

  def down
    drop_table :galleries_photos
  end
end
