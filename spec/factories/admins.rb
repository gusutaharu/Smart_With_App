FactoryBot.define do
  factory :admin do
    name { "管理者" }
    sequence(:email) { |n| "admin_#{n}@example.com" }
    password { "password" }
  end
end
