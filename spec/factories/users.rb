FactoryGirl.define do
  factory :user do
    email = Faker::Internet.email
    provider :email
    uid email
    email email
  end
end
