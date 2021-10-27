require 'rails_helper'

RSpec.describe "UsersSessions", type: :request do
  let!(:user_a) { create(:user_a) }
  let(:user_params) { { user: { id: user_a.id, email: user_a.email, password: user_a.password } } }

  describe "GET /resource/sign_in" do
    subject { get new_user_session_path }

    context "ログインをしている場合" do
      it "トップページにリダイレクトされること" do
        sign_in user_a
        is_expected.to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      it "リクエストが成功すること" do
        is_expected.to eq 200
      end
    end
  end

  describe "POST /resource/sign_in" do
    subject { post user_session_url, params: user_params }

    context "ログインをしている場合" do
      it "トップページにリダイレクトされること" do
        sign_in user_a
        is_expected.to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      it "リクエストが成功すること" do
        subject
        is_expected.to eq 302
      end
    end
  end

  describe "DELETE /resource/sign_out" do
    subject { delete destroy_user_session_path }

    before do
      sign_in user_a
    end

    it "リクエストが成功すること" do
      is_expected.to eq 302
    end

    it "トップページにリダイレクトされること" do
      is_expected.to redirect_to root_path
    end

    it "ログアウトされていること" do
      subject
      expect(session[:user_id].nil?).to be true
    end
  end
end
