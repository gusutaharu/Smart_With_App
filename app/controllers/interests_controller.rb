class InterestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @interest = Interest.new(user_id: current_user.id, question_id: params[:question_id])
    @interest.save
    @question = @interest.question
  end

  def destroy
    @interest = Interest.find_by(user_id: current_user.id, question_id: params[:question_id])
    @interest.destroy
    @question = @interest.question
  end
end
