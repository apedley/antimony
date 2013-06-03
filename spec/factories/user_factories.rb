FactoryGirl.define do
  sequence(:email) {|n| "email#{n}@factory.com"}
  sequence(:username) {|n| "somename#{n}"}
  factory :user do
    email
    username
    password "derp123"
    password_confirmation "derp123"
    factory :user_with_photos do
      after(:create) do |user|
        user.photos << FactoryGirl.create(:photo)
      end
    end

  end
end

