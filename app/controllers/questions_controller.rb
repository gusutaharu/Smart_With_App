class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:confirm_new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  RECENT_QUESTIONS = 6

  def index
    questions = Question.all.order(created_at: :desc)
    @question_top = questions.first
    @questions = questions.limit(RECENT_QUESTIONS).drop(1)
    answers = Answer.all.order(created_at: :desc).pluck(:question_id).uniq
    @answered_questions = Question.find(answers)
    @unanswered_questions = Question.where.not(id: answers).order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.order(created_at: :desc)
    @answer_reply = @question.answers.new
  end

  def new
    @question = Question.new
    unless user_signed_in?
      flash[:notice] = "質問を投稿するにはログインが必要です"
      redirect_to new_user_session_path
    end
  end

  def confirm_new
    @question = current_user.questions.new(question_params)
    render :new unless @question.valid?
  end

  def create
    @question = current_user.questions.new(question_params)
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
    if @question.update(question_params)
      redirect_to question_url, notice: "質問を更新しました"
    else
      render :new
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to root_url, notice: "質問を削除しました。"
  end

  def search_results
    @questions = @q.result.order(created_at: :desc).page(params[:page]).per(5)
    @key_word = params[:q]["title_or_information_or_content_cont"]
  end

  private

  def ensure_correct_user
    @question = Question.find_by(id: params[:id])
    if @question.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end

  def question_params
    params.require(:question).permit(:title, :information, :content, { question_images: [] })
  end
end
