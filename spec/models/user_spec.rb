require 'rails_helper'

RSpec.describe User, type: :model do
  it "名前、メールアドレス、パスワードが設定されているユーザーを登録できること" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "名前が設定されていないユーザーを登録できないこと" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "名前が20文字を超えるユーザーを登録できないこと" do
    user = FactoryBot.build(:user, name: "a" * 21)
    user.valid?
    expect(user.errors[:name]).to include("は20文字以内で入力してください")
  end

  it "メールアドレスが設定されていないユーザーを登録できないこと" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "同一のメールアドレスを設定してユーザーを登録できないこと" do
    FactoryBot.create(:user, email: "user@example.com")
    user = FactoryBot.build(:user, email: "user@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードが設定されていないユーザーを登録できないこと" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが6文字に満たないユーザーを登録できなこと" do
    user = FactoryBot.build(:user, password: "a" * 5)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "パスワードが128文字を超えるユーザーを登録できないこと" do
    user = FactoryBot.build(:user, password: "a" * 129)
    user.valid?
    expect(user.errors[:password]).to include("は128文字以内で入力してください")
  end
end
