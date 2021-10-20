require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /show" do
    subject { get user_path user.id }

    it "ステータスコードが200であること" do
      is_expected.to eq 200
    end
    it "ユーザー名が表示されていること" do
      subject
      expect(response.body).to include user.name
    end
  end
end
