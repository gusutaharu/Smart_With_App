class ApplicationController < ActionController::Base
  before_action :set_keyword
  before_action :configure_permitted_parameters, if: :devise_controller?

  def search_results
    @search_results = @q.result.order(created_at: :desc).page(params[:page]).per(5)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def set_keyword
    @q = Question.ransack(params[:q])
  end
end
