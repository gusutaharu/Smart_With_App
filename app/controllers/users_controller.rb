class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    interests = Interest.where(user_id: @user.id).recent.pluck(:question_id)
    @interesting_questions = Question.find(interests)
    answers = Answer.where(user_id: @user.id, parent_id: nil).recent.pluck(:question_id)
    @answered_questions = Question.find(answers)
  end
end
