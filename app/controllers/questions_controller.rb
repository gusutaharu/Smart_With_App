class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    @question.save!
    redirect_to questions_url, notice: "質問が作成されました"
  end

  def edit
  end

  private

  def question_params
    params.require(:question).permit(:title,:information,:content)
  end
end
