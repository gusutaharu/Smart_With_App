class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:confirm_new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  RECENT_QUESTIONS = 6

  def index
    questions = Question.all.recent
    @question_top = questions.first
    @questions = questions.limit(RECENT_QUESTIONS).drop(1)
    answers = Answer.all.recent.pluck(:question_id).uniq
    @answered_questions = Question.find(answers)
    @unanswered_questions = Question.where.not(id: answers).recent
    @category_hardware = Category.where(ancestry: nil)
    @category_smart_os = Category.find(1).children
    @all_condition = Category.find(4).children
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.recent
    @answer_reply = @question.answers.new
  end

  def new
    @question = Question.new(session[:question] || {})
    @category_hardware = [""]
    Category.where(ancestry: nil).each do |hardware|
      @category_hardware << [hardware.name, hardware.id]
    end

    def get_category_os
      @category_os = Category.find("#{params[:hardware_id]}").children
    end

    def get_category_condition
      @category_condition = Category.find("#{params[:os_id]}").children
    end

    unless user_signed_in?
      redirect_to new_user_session_path, flash: { danger: "質問を投稿するにはログインが必要です" }
    end
  end

  def confirm_new
    @question = current_user.questions.new(question_params)
    render :new unless @question.valid?
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      session[:question] = nil
      redirect_to questions_url, flash: { success: "質問が作成されました" }
    else
      session[:question] = @question.attributes.slice(*question_params.keys)
      flash[:danger] = @question.errors.full_messages
      redirect_to new_question_url
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to question_url, flash: { success: "質問を更新しました" }
    else
      flash[:danger] = @question.errors.full_messages
      redirect_to edit_question_url @question
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to root_url, flash: { success: "質問を削除しました" }
  end

  def search_results
    @questions = @q.result.recent.page(params[:page]).per(5)
    if params[:hardware_name] && params[:os_name]
      @key_word = "#{params[:hardware_name]}/#{params[:os_name]}/#{Category.find(params[:q]["categories_id_eq"]).name}"
    elsif params[:hardware_name]
      @key_word = "#{params[:hardware_name]}/#{params[:q]["categories_name_eq"]}"
    else
      @key_word = params[:q]["title_or_information_or_content_cont"] || params[:q]["categories_name_eq"]
    end
  end

  private

  def ensure_correct_user
    @question = Question.find_by(id: params[:id])
    if @question.user_id != current_user.id
      redirect_to root_path, flash: { danger: "権限がありません" }
    end
  end

  def question_params
    params.require(:question).permit(:title, :information, :content, { question_images: [] }, category_ids: [])
  end
end
