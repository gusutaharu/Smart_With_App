FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "質問#{n}" }
    information { "機種 iPhoneX" }
    content { "OSのアップデート" }
    association :user
  end
end
