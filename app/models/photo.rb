class Photo < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :galleries
  attr_accessible :title, :image, :remote_image_url, :gallery_ids, :public, :image_processing
  mount_uploader :image, ImageUploader
  process_in_background :image

  # default_scope where(:image_processing => nil)
  paginates_per 36

  # Custom validator for file size
  validates :image,
    :presence => true,
    :file_size => {
      :maximum => 1.0.megabytes.to_i
    }

  validates :title,
    :presence => true,
    :length => { :in => 2..80 }

  def self.public
    where(:public => true)
  end

  def self.processed
    where(:image_processing => nil)
  end

end
