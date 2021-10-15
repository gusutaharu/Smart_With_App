class QuestionsController < ApplicationController
  before_action :set_keyword
  RECENT_QUESTIONS = 5

  def index
    questions = Question.all.order(created_at: :desc)
    @question_top = questions.first
    @questions = Question.where.not(id: @question_top.id).limit(RECENT_QUESTIONS)
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def confirm_new
    @question = current_user.questions.new(question_params)
    render :new unless @question.valid?
  end

  def create
    @question = current_user.questions.new(question_params)
    if params[:back].present?
      render :new
      return
    end

    if @question.save
      redirect_to questions_url, notice: "質問が作成されました"
    else
      render :new
    end
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

  def search_results
    @search_results = @q.result.order(created_at: :desc).page(params[:page]).per(5)
  end

  private

  def question_params
    params.require(:question).permit(:title, :information, :content)
  end

  def set_keyword
    @q = Question.ransack(params[:q])
  end
end
