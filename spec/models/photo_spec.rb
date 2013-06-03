require 'spec_helper'

describe Photo do
  it { build_stubbed(:photo).should be_valid }
  it { build_stubbed(:photo).user.should_not be(nil) }

  it "returns public images" do
    public_photo = create(:photo)
    private_photo = create(:photo, public: false)
    expect(Photo.public).to_not include(private_photo)
  end
end
