FactoryBot.define do
  factory :user do
    name { "ユーザー" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
  end
end
