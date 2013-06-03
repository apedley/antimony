class Photo < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :galleries
  attr_accessible :title, :image, :remote_image_url, :gallery_ids, :public
  mount_uploader :image, ImageUploader

  paginates_per 36

  validates :image,
    :presence => true,
    :file_size => {
      :maximum => 1.0.megabytes.to_i
    }
  validates :title,
    :presence => true
  def self.public
    where(:public => true)
  end

end
