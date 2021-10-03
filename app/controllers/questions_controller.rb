class QuestionsController < ApplicationController
  NEW_QUESTIONS_COUNT = 5
  def index
    @question_top_id = Question.all.ids.max
    @question_top = Question.find(@question_top_id)
    @questions = Question.where.not(id: @question_top_id).limit(NEW_QUESTIONS_COUNT)
    @questions_sort = Question.all
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
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update!(question_params)
    redirect_to question_url, notice: "質問を更新しました"
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to root_url, notice: "質問を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :information, :content)
  end
end
