FactoryGirl.define do
  factory :photo do
    sequence(:title) {|n| "sometitle#{n}"}
    
    public true
    user
    factory :photo_with_galleries do
      after(:create) do |photo|
        photo.galleries << FactoryGirl.create(:gallery)
      end
    end
  end
end
