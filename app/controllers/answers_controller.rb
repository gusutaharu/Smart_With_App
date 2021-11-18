class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    @answer.save
    render :answer
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    render :answer
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :question_id, { images: [] })
  end
end
