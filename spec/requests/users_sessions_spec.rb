require 'rails_helper'

RSpec.describe "UsersSessions", type: :request do
  let!(:user_a) { create(:user, name: "user_a", email: "user_a@email.com", password: "password") }
  let(:user_params) { attributes_for(:user, email: "user_a@email.com", password: "password") }

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
    subject { post new_user_session_path, params: { user: user_params } }

    context "ログインをしている場合" do
      it "トップページにリダイレクトされること" do
        sign_in user_a
        is_expected.to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      it "リクエストが成功すること" do
        is_expected.to eq 302
      end
    end
  end

  describe "DELETE /resource/sign_out" do
    context "ログインをしている場合" do
      it "トップページにリダイレクトされること" do
        sign_in user_a
        delete destroy_user_session_path
        expect(response).to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      it "トップページにリダイレクトされないこと" do
        delete destroy_user_session_path user_a
        expect(response).not_to redirect_to root_path
      end
    end
  end
end
