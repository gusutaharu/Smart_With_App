require 'rails_helper'

RSpec.describe "Questions", type: :request do
  before do
    @question = FactoryBot.create(:question)
  end

  describe "GET /index" do
    it "正常なレスポンスを返す" do
      FactoryBot.create_list(:question, 5)
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "正常なレスポンスを返す" do
      get question_path(@question.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "正常なレスポンスを返す" do
      get new_question_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "正常なレスポンスを返す" do
      get edit_question_path(@question.id)
      expect(response).to have_http_status(:success)
    end
  end
end
