require 'spec_helper'

describe User do
  it { build_stubbed(:user).should be_valid }


  it "should return public photos" do
    user = create(:user)
    private_photo = create(:photo, user: user, public: false)
    public_photo = create(:photo, user:user, public: true)
    expect(user.public_photos).to eq([public_photo])
  end

  it "should return public galleries" do
    user = create(:user)
    public_gallery = create(:gallery, user: user, public:true)
    private_gallery = create(:gallery, user: user, public:false)
    expect(user.public_galleries).to eq([public_gallery])
  end

  it "should return uncategorized photos" do
    user = create(:user)
    gallery = create(:gallery, user:user)
    photo_with_gallery = create(:photo, user:user, galleries: [gallery])
    photo_without_gallery = create(:photo, user:user)
    expect(user.uncategorized_photos).to eq([photo_without_gallery])
  end

  it "should return photos not in a gallery" do
    user = create(:user)
    gallery_one = create(:gallery, user: user)
    gallery_two = create(:gallery, user: user)
    photo_in_gallery_one = create(:photo, user:user, galleries: [gallery_one])
    photo_in_gallery_two = create(:photo, user:user, galleries: [gallery_two])
    expect(user.photos_not_in(gallery_one)).to eq([photo_in_gallery_two])
  end
end
