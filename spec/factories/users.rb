FactoryBot.define do
  factory :user do
    name { "ユーザー" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
  end
end
