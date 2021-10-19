require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question) }

  describe "GET /index" do
    it "正常なレスポンスを返す" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "正常なレスポンスを返す" do
      get question_path(question.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    context "ログインしている場合" do
      it "正常なレスポンスを返すこと" do
        sign_in user
        get new_question_path
        expect(response).to have_http_status(:success)
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        get new_question_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /confirm_new" do
    context "ログインしている場合" do
      before do
        sign_in user
      end

      context "有効な属性の場合" do
        it "入力した質問が受け取れていること" do
          question_params = FactoryBot.attributes_for(:question, title: "質問作成のフォームで入力した質問")
          post confirm_new_question_path, params: { question: question_params }
          expect(response.body).to include "質問作成のフォームで入力した質問"
        end
      end

      context "無効な属性の場合" do
        it "有効な属性の入力を求めるエラーが表示されること" do
          question_params = FactoryBot.attributes_for(:question, title: "")
          post confirm_new_question_path, params: { question: question_params }
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        question_params = FactoryBot.attributes_for(:question)
        post confirm_new_question_path, params: { question: question_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "POST /create" do
    context "ログインしている場合" do
      before do
        sign_in user
      end

      context "有効な属性の場合" do
        it "入力した質問が受け取れていること" do
          question_params = FactoryBot.attributes_for(:question, title: "質問作成のフォームで入力した質問")
          expect { post questions_path, params: { question: question_params } }.to change(Question, :count).by(1)
        end
      end

      context "無効な属性の場合" do
        it "有効な属性の入力を求めるエラーが表示されること" do
          question_params = FactoryBot.attributes_for(:question, title: "")
          post questions_path, params: { question: question_params }
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        question_params = FactoryBot.attributes_for(:question)
        post questions_path, params: { question: question_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GET /edit" do
    let(:other_user) { FactoryBot.create(:user, name: "ohter_user") }
    let(:my_question) { FactoryBot.create(:question, user_id: user.id) }

    context "質問の投稿者がログインしている場合" do
      it "正常なレスポンスを返す" do
        sign_in user
        get edit_question_path(my_question.id)
        expect(response).to have_http_status(:success)
      end
    end

    context "質問の投稿主ではないユーザーがログインしている場合" do
      it "トップページにリダイレクトすること" do
        sign_in other_user
        get edit_question_path(my_question.id)
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get edit_question_path(my_question.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH /update" do
    let(:other_user) { FactoryBot.create(:user, name: "ohter_user") }
    let(:question_a) { FactoryBot.create(:question, title: "更新前の質問", user_id: user.id) }

    context "質問の投稿者がログインしている場合" do
      before do
        sign_in user
      end

      context "有効な属性の場合" do
        it "質問が更新されていること" do
          question_params = FactoryBot.attributes_for(:question, title: "更新後の質問")
          expect { patch question_path question_a, params: { id: question_a.id, question: question_params } }.to change {
            question_a.reload.title
          }.from("更新前の質問").to("更新後の質問")
        end
      end

      context "無効な属性の場合" do
        it "有効な属性の入力を求めるエラーが表示されること" do
          question_params = FactoryBot.attributes_for(:question, title: "")
          patch question_path question_a, params: { id: question_a.id, question: question_params }
          expect(response.body).to include "Titleを入力してください"
        end
      end
    end

    context "質問の投稿者ではないユーザーがログインしている場合" do
      it "トップページにリダイレクトすること" do
        sign_in other_user
        question_params = FactoryBot.attributes_for(:question)
        patch question_path question_a, params: { id: question_a.id, question: question_params }
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        question_params = FactoryBot.attributes_for(:question)
        patch question_path question_a, params: { question: question_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE /destroy" do
    let(:other_user) { FactoryBot.create(:user, name: "ohter_user") }
    let!(:my_question) { FactoryBot.create(:question, user_id: user.id) }

    context "質問の投稿者がログインしている場合" do
      it "質問を削除できること" do
        sign_in user
        expect { delete question_url my_question }.to change(Question, :count).by(-1)
      end
    end

    context "質問の投稿者ではないユーザーがログインしている場合" do
      it "トップページにリダイレクトすること" do
        sign_in other_user
        delete question_path my_question
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていない場合" do
      it "ログインページにリダイレクすること" do
        delete question_path my_question
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
