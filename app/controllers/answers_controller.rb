class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    @answer_reply = @question.answers.new
    if @answer.save
      flash.now[:notice] = "投稿に成功しました"
      render :answer
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :answer
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer_reply = @question.answers.new
    @answer = Answer.find(params[:id])
    @answer.destroy
    render :answer
  end

  private

  def answer_params
    params.require(:answer).permit(:content, :user_id, :question_id, { images: [] }, :parent_id)
  end
end
