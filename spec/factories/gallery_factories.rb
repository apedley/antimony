FactoryGirl.define do
  factory :gallery do
    
    sequence(:name) {|n| "somename#{n}"}

    public true

    user
    factory :gallery_with_photos do
      after(:create) do |gallery|
        gallery.photos << FactoryGirl.create(:photo)
      end
    end
  end
end