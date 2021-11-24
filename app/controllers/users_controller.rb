class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    interests = Interest.where(user_id: @user.id).order(created_at: :desc).pluck(:question_id)
    @interesting_questions = Question.find(interests)
    answers = Answer.where(user_id: @user.id, parent_id: nil).order(created_at: :desc).pluck(:question_id)
    @answered_questions = Question.find(answers)
  end
end
