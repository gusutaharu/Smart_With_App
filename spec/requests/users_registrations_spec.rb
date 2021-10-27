require 'rails_helper'

RSpec.describe "UsersRegistrations", type: :request do
  let!(:user_a) { create(:user_a) }
  let(:other_user) { create(:user, name: "other_user") }
  let(:valid_user_params) { attributes_for(:user, name: "new_name") }
  let(:invalid_user_params) { attributes_for(:user, :blank_name) }

  describe "GET /resource/sign_up" do
    subject { get new_user_registration_path }

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

  describe "POST /resource" do
    subject { post user_registration_path, params: { user: user_params } }

    context "ログインをしている場合" do
      let(:user_params) { valid_user_params }

      it "トップページにリダイレクトされること" do
        sign_in user_a
        is_expected.to redirect_to root_path
      end
    end

    context "ログインをしていない場合" do
      context "有効な属性の場合" do
        let(:user_params) { valid_user_params }

        it "リクエストが成功すること" do
          is_expected.to eq 302
        end

        it "ユーザーが登録されること" do
          expect { subject }.to change(User, :count).by(1)
        end
      end

      context "無効な属性の場合" do
        let(:user_params) { invalid_user_params }

        it "ユーザーが登録されないこと" do
          expect { subject }.not_to change(User, :count)
        end
        it "エラーが表示されること" do
          subject
          expect(response.body).to include "名前を入力してください"
        end
      end
    end
  end

  describe "GET /resource/edit" do
    subject { get edit_user_registration_path user_a }

    context "ログインをしている場合" do
      it "リクエストが成功すること" do
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
    subject { patch user_registration_path, params: { user: user_params } }

    context "ログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        let(:user_params) { valid_user_params }

        it "リクエストが成功すること" do
          is_expected.to eq 302
        end

        it "名前が更新されていること" do
          expect { subject }.to change {
            user_a.reload.name
          }.from("user_a").to("new_name")
        end
      end

      context "無効な属性の場合" do
        let(:user_params) { invalid_user_params }

        it "エラーが表示されること" do
          subject
          expect(response.body).to include "名前を入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      let(:user_params) { valid_user_params }

      it "リダイレクトされること" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE /resource" do
    subject { delete user_registration_path }

    before do
      sign_in user_a
    end

    it "リクエストが成功すること" do
      is_expected.to eq 302
    end

    it "ユーザーを削除できること" do
      expect { subject }.to change(User, :count).by(-1)
    end
  end
end
