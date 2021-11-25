FactoryBot.define do
  factory :answer do
    user_id { 1 }
    question_id { 1 }
    content { "MyText" }
    images { "" }
  end
end
