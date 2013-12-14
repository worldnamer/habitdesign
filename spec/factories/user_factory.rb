FactoryGirl.define do
  factory :user do
    email "test@example.org"
    password "password"
    password_confirmation "password"
    remember_me false
  end
end