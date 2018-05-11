class Api::V1::AnswersController < Api::V1::BaseController
  before_action :set_question, only: :index

  authorize_resource

  def index
    respond_with @question.answers
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end