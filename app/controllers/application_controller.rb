class ApplicationController < ActionController::Base
  before_action :set_keyword
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def set_keyword
    @q = Question.ransack(params[:q])
  end
end
