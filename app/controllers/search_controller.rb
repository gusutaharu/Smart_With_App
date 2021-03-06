class SearchController < ApplicationController
  def index
    @questions = @q.result.recent.page(params[:page]).per(5)
    answers = Answer.where(parent_id: nil).select(:question_id).distinct
    @answered_questions = @q.result.where(id: answers).recent.page(params[:page_b]).per(5)
    @unanswered_questions = @q.result.where.not(id: answers).recent.page(params[:page_a]).per(5)
    if params[:hardware_name] && params[:os_name]
      @key_word = "#{params[:hardware_name]}/#{params[:os_name]}/#{Category.find(params[:q]["categories_id_eq"]).name}"
    elsif params[:hardware_name]
      @key_word = "#{params[:hardware_name]}/#{params[:q]["categories_name_eq"]}"
    else
      @key_word = params[:q]["title_or_information_or_content_cont"] || params[:q]["categories_name_eq"]
    end
  end
end
