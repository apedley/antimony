class RemoveImageTmpFromPhotos < ActiveRecord::Migration
  def up
    remove_column :photos, :image_tmp
    remove_column :photos, :remote_image_url
  end

  def down
  end
end
