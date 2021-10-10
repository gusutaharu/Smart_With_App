require 'rails_helper'

RSpec.describe Question, type: :model do
  it "タイトルが20文字以内で、情報、内容があり有効である" do
    expect(FactoryBot.build(:question)).to be_valid
  end

  it "タイトルが空欄の時、無効である" do
    question = FactoryBot.build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("を入力してください")
  end

  it "タイトルが20文字より多い時、無効である" do
    question = FactoryBot.build(:question, title: "a" * 21)
    question.valid?
    expect(question.errors[:title]).to include("は20文字以内で入力してください")
  end

  it "情報が空欄の時、無効である" do
    question = FactoryBot.build(:question, information: nil)
    question.valid?
    expect(question.errors[:information]).to include("を入力してください")
  end

  it "内容が空欄の時、無効である" do
    question = FactoryBot.build(:question, content: nil)
    question.valid?
    expect(question.errors[:content]).to include("を入力してください")
  end
end
