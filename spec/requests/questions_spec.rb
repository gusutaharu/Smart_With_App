require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user_a) { create(:user_a) }
  let(:other_user) { create(:user, :ohter_user) }
  let!(:question_a) { create(:question, title: "user_aの質問", user_id: user_a.id) }
  let(:valid_question_params) { attributes_for(:question, title: "新しいタイトル") }
  let(:invalid_question_params) { attributes_for(:question, title: "") }

  describe "GET /index" do
    it "リクエストが成功すること" do
      get root_path
      expect(response).to have_http_status 200
    end
  end

  describe "GET /show" do
    subject { get question_path question_a.id }

    it "リクエストが成功すること" do
      is_expected.to eq 200
    end

    it "質問が表示されていること" do
      subject
      expect(response.body).to include question_a.title
    end
  end

  describe "GET /new" do
    subject { get new_question_path }

    context "ログインしている場合" do
      it "リクエストが成功すること" do
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

  describe "POST /create" do
    subject { post questions_path, params: { question: question_params } }

    context "ログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        let(:question_params) { valid_question_params }

        it "リクエストが成功すること" do
          is_expected.to eq 302
        end

        it "入力した質問が受け取れていること" do
          expect { subject }.to change(Question, :count).by(1)
        end
      end

      xcontext "無効な属性の場合" do
        let(:question_params) { invalid_question_params }

        it "有効な属性の入力を求めるエラーが表示されること" do
          subject
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      let(:question_params) { valid_question_params }

      it "ログインページにリダイレクすること" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /edit" do
    subject { get edit_question_path question_a.id }

    context "質問の投稿者がログインしている場合" do
      it "リクエストが成功すること" do
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
    subject { patch question_path question_a, params: { question: question_params } }

    context "質問の投稿者がログインしている場合" do
      before do
        sign_in user_a
      end

      context "有効な属性の場合" do
        let(:question_params) { valid_question_params }

        it "リクエストが成功すること" do
          is_expected.to eq 302
        end

        it "質問が更新されていること" do
          expect { subject }.to change {
            question_a.reload.title
          }.from("user_aの質問").to("新しいタイトル")
        end
      end

      xcontext "無効な属性の場合" do
        let(:question_params) { invalid_question_params }

        it "有効な属性の入力を求めるエラーが表示されること" do
          subject
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "質問の投稿者ではないユーザーがログインしている場合" do
      let(:question_params) { valid_question_params }

      it "トップページにリダイレクトすること" do
        sign_in other_user
        is_expected.to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      let(:question_params) { valid_question_params }

      it "ログインページにリダイレクすること" do
        is_expected.to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE /destroy" do
    subject { delete question_url question_a }

    context "質問の投稿者がログインしている場合" do
      it "リクエストが成功すること" do
        is_expected.to eq 302
      end

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
