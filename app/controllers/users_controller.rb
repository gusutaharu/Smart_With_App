class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = @user.questions.recent.page(params[:page_post]).per(5)
    @interesting_questions = Question.joins(:interests).where(interests: { user_id: @user.id }).order("interests.created_at desc").page(params[:page_interest]).per(5)
    @answered_questions = Question.joins(:answers).where(answers: { user_id: @user.id, parent_id: nil }).order("answers.created_at desc").page(params[:page_answer]).per(5)
  end
end
