require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "名前、メールアドレス、パスワードが設定されている管理者を登録できること" do
    expect(FactoryBot.build(:admin)).to be_valid
  end

  it "名前が設定されていない管理者を登録できないこと" do
    admin = FactoryBot.build(:admin, name: nil)
    admin.valid?
    expect(admin.errors[:name]).to include("を入力してください")
  end

  it "名前が20文字を超える管理者を登録できないこと" do
    admin = FactoryBot.build(:admin, name: "a" * 21)
    admin.valid?
    expect(admin.errors[:name]).to include("は20文字以内で入力してください")
  end

  it "メールアドレスが設定されていない管理者を登録できないこと" do
    admin = FactoryBot.build(:admin, email: nil)
    admin.valid?
    expect(admin.errors[:email]).to include("を入力してください")
  end

  it "同一のメールアドレスを設定して管理者を登録できないこと" do
    FactoryBot.create(:admin, email: "admin@example.com")
    admin = FactoryBot.build(:admin, email: "admin@example.com")
    admin.valid?
    expect(admin.errors[:email]).to include("はすでに存在します")
  end

  it "パスワードが設定されていない管理者を登録できないこと" do
    admin = FactoryBot.build(:admin, password: nil)
    admin.valid?
    expect(admin.errors[:password]).to include("を入力してください")
  end

  it "パスワードが6文字に満たない管理者を登録できなこと" do
    admin = FactoryBot.build(:admin, password: "a" * 5)
    admin.valid?
    expect(admin.errors[:password]).to include("は6文字以上で入力してください")
  end

  it "パスワードが128文字を超える管理者を登録できないこと" do
    admin = FactoryBot.build(:admin, password: "a" * 129)
    admin.valid?
    expect(admin.errors[:password]).to include("は128文字以内で入力してください")
  end
end
