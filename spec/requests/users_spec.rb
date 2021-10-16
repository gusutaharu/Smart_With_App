require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = FactoryBot.create(:user)
  end

  describe "GET /show" do
    it "returns http success" do
      get user_path(@user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
