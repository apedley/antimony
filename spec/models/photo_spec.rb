require 'spec_helper'

describe Photo do
  it { build_stubbed(:photo).should be_valid }
  it { build_stubbed(:photo).user.should_not be(nil) }
  it { build_stubbed(:photo, :title => nil).should_not be_valid }
  it { build_stubbed(:photo, :title => 'a').should_not be_valid }
  it { build_stubbed(:photo, :title => 'a'*81).should_not be_valid }
  it { build_stubbed(:photo, :image => nil).should_not be_valid }

  it "returns public images" do
    public_photo = create(:photo)
    private_photo = create(:photo, public: false)
    expect(Photo.public).to_not include(private_photo)
  end
  it "returns processed images" do
    photo = create(:photo)
    unfinished_photo = create(:photo, image_processing: true)
    expect(Photo.processed).to_not include(unfinished_photo)
  end
end
