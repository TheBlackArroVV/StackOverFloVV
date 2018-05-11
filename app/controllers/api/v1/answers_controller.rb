class Api::V1::AnswersController < Api::V1::BaseController
  before_action :set_question, only: :index
  before_action :set_answer, only: :show

  authorize_resource

  def index
    respond_with @question.answers
  end

  def show
    respond_with @answer
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end
end