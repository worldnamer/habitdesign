FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test+#{n}@example.org" }
    password "password"
    password_confirmation "password"
    remember_me false
  end
end