require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let!(:user_a) { create(:user, name: "user_a") }
  let(:other_user) { create(:user, name: "other_user") }
  let(:user_params) { attributes_for(:user, name: "new_name") }
  let(:invalid_user_params) { attributes_for(:user, name: "") }

  describe "GET /resource/sign_up" do
    context "ログインをしている場合" do
      it "リダイレクトされること" do
        sign_in user_a
        get new_user_registration_path
        expect(response).to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      it "ステータスコードが200であること" do
        get new_user_registration_path
        expect(response).to have_http_status 200
      end
    end
  end

  describe "POST /resource" do
    context "ログインをしている場合" do
      it "リダイレクトされること" do
        sign_in user_a
        post user_registration_path
        expect(response).to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      context "有効な属性の場合" do
        it "ユーザーが登録されること" do
          expect { post user_registration_path, params: { user: user_params } }.to change(User, :count).by(1)
        end
      end

      context "無効な属性の場合" do
        it "ユーザーが登録されないこと" do
          expect { post user_registration_path, params: { user: invalid_user_params } }.not_to change(User, :count)
        end
        it "エラーが表示されること" do
          post user_registration_path, params: { user: invalid_user_params }
          expect(response.body).to include "名前を入力してください"
        end
      end
    end
  end

  describe "GET /resource/edit" do
    subject { get edit_user_registration_path user_a }

    context "ログインをしている場合" do
      it "ステータスコードが200であること" do
        sign_in user_a
        is_expected.to eq 200
      end
    end

    context "他のユーザーでログインしている場合" do
      it "ログインユーザー以外の編集画面が表示されないこと" do
        sign_in other_user
        subject
        expect(response.body).not_to include user_a.name
      end
    end

    context "ログインをしていない場合" do
      it "エラーが表示されること" do
        subject
        expect(response.body).to include "ログインもしくはアカウント登録してください。"
      end
    end
  end

  describe "PATCH /resource" do
    context "ログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        it "名前が更新されていること" do
          expect { patch user_registration_path, params: { user: user_params } }.to change {
            user_a.reload.name
          }.from("user_a").to("new_name")
        end
      end

      context "無効な属性の場合" do
        it "エラーが表示されること" do
          patch user_registration_path, params: { user: invalid_user_params }
          expect(response.body).to include "名前を入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      it "リダイレクトされてること" do
        patch user_registration_path, params: { user: invalid_user_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
