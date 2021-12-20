require 'rails_helper'

RSpec.describe Question, type: :model do
  xit "20文字以内のタイトルと、情報、内容が設定されている質問を登録できること" do
    expect(create(:question)).to be_valid
  end

  it "タイトルが設定されていない質問を登録できないこと" do
    question = build(:question, title: nil)
    question.valid?
    expect(question.errors[:title]).to include("を入力してください")
  end

  it "タイトルが20文字を超える質問を登録できないこと" do
    question = build(:question, title: "a" * 21)
    question.valid?
    expect(question.errors[:title]).to include("は20文字以内で入力してください")
  end

  it "情報が設定されていない質問を登録できないこと" do
    question = build(:question, information: nil)
    question.valid?
    expect(question.errors[:information]).to include("を入力してください")
  end

  it "内容が設定されていない質問を登録できないこと" do
    question = build(:question, content: nil)
    question.valid?
    expect(question.errors[:content]).to include("を入力してください")
  end
end
