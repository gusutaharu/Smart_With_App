FactoryBot.define do
  factory :user do
    name { "ユーザー" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }

    trait :blank_name do
      name { nil }
    end

    trait :ohter_user do
      name { "other_user" }
    end
  end

  factory :user_a, class: "User" do
    name { "user_a" }
    email { "user_a@example.com" }
    password { "password" }
  end
end
