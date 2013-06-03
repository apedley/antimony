class Gallery < ActiveRecord::Base
  attr_accessible :name, :photo_ids, :public, :user, :cover_photo_id

  has_and_belongs_to_many :photos
  belongs_to :user
  paginates_per 50
  
  def cover_photo_url
    if self.photos.empty?
      '/assets/nopreview.png'
    else
      self.photos.first.image_url(:thumb)
    end
  end
  def self.public
    where(:public => true)
  end

  def public_photos
    self.photos.select { |p| p.public }
  end

  def make_private
    self.photos.each do |photo|
      photo.public = false
      photo.save
    end
    self.update_attribute(:public, false)
  end
end
