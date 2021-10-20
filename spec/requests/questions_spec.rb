require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user_a) { create(:user) }
  let(:other_user) { create(:user, name: "ohter_user") }
  let!(:question_a) { create(:question, title: "user_aの質問", user_id: user_a.id) }
  let(:question) { create(:question) }
  let(:question_params) { attributes_for(:question) }
  let(:invalid_question_params) { attributes_for(:question, title: "") }

  describe "GET /index" do
    it "ステータスコードが200であること" do
      get root_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /show" do
    it "ステータスコードが200であること" do
      get question_path(question.id)
      expect(response).to have_http_status 200
    end
  end

  describe "GET /new" do
    subject { get new_question_path }

    context "ログインしている場合" do
      it "ステータスコードが200であること" do
        sign_in user_a
        is_expected.to eq 200
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /confirm_new" do
    context "ログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        it "入力した質問が受け取れていること" do
          question_params = attributes_for(:question, title: "質問作成のフォームで入力した質問")
          post confirm_new_question_path, params: { question: question_params }
          expect(response.body).to include "質問作成のフォームで入力した質問"
        end
      end

      context "無効な属性の場合" do
        it "有効な属性の入力を求めるエラーが表示されること" do
          post confirm_new_question_path, params: { question: invalid_question_params }
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        post confirm_new_question_path, params: { question: question_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /create" do
    context "ログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        it "入力した質問が受け取れていること" do
          expect { post questions_path, params: { question: question_params } }.to change(Question, :count).by(1)
        end
      end

      context "無効な属性の場合" do
        it "有効な属性の入力を求めるエラーが表示されること" do
          post questions_path, params: { question: invalid_question_params }
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        post questions_path, params: { question: question_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /edit" do
    subject { get edit_question_path(question_a.id) }

    context "質問の投稿者がログインしている場合" do
      it "ステータスコードが200であること" do
        sign_in user_a
        is_expected.to eq 200
      end
    end

    context "質問の投稿主ではないユーザーがログインしている場合" do
      it "トップページにリダイレクトすること" do
        sign_in other_user
        is_expected.to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH /update" do
    context "質問の投稿者がログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        it "質問が更新されていること" do
          question_params = attributes_for(:question, title: "更新後の質問")
          expect { patch question_path question_a, params: { id: question_a.id, question: question_params } }.to change {
            question_a.reload.title
          }.from("user_aの質問").to("更新後の質問")
        end
      end

      context "無効な属性の場合" do
        it "有効な属性の入力を求めるエラーが表示されること" do
          patch question_path question_a, params: { id: question_a.id, question: invalid_question_params }
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "質問の投稿者ではないユーザーがログインしている場合" do
      it "トップページにリダイレクトすること" do
        sign_in other_user
        patch question_path question_a, params: { id: question_a.id, question: question_params }
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        patch question_path question_a, params: { question: question_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete question_url question_a }

    context "質問の投稿者がログインしている場合" do
      it "質問を削除できること" do
        sign_in user_a
        expect { subject }.to change(Question, :count).by(-1)
      end
    end

    context "質問の投稿者ではないユーザーがログインしている場合" do
      it "トップページにリダイレクトすること" do
        sign_in other_user
        is_expected.to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end
end
