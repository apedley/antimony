require 'spec_helper'

describe Gallery do
  it { build_stubbed(:gallery).should be_valid }
  it { build_stubbed(:gallery).user.should_not be(nil) }
  

  it "should offer a cover photo" do
    gallery = Gallery.new
    expect(gallery.cover_photo_url).to_not be(nil)
  end

  it "shows public galleries" do
    public_gallery = build_stubbed(:gallery)
    private_gallery = build_stubbed(:gallery, public: false)

    expect(Gallery.public).to_not include(private_gallery)
  end

  it "has public photos" do
    gallery = create(:gallery)
    public_photo = create(:photo, galleries: [gallery])
    private_photo = create(:photo, galleries: [gallery], public: false)
    expect(gallery.public_photos).to eq([public_photo])
  end

  it "makes self and all photos private" do
    gallery = create(:gallery)
    photo = create(:photo, galleries: [gallery])
    gallery.make_private
    expect(gallery.photos.first.public).to eq(false)
  end
end
