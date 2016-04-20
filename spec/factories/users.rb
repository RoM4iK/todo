FactoryGirl.define do
  factory :user do
    email = Faker::Internet.safe_email
    provider :email
    uid email
    email email
    password Faker::Internet.password(8)
  end
end
