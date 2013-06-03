FactoryGirl.define do
  factory :photo do
    sequence(:title) {|n| "sometitle#{n}"}
    
    public true
    user
    image File.open(Rails.root.join("spec/files/test.png"))
    # Please no galleries with photos with galleries..
    factory :photo_with_galleries do
      after(:create) do |photo|
        photo.galleries << FactoryGirl.create(:gallery)
      end
    end
  end
end
