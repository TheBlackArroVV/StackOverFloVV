class Api::V1::AnswersController < Api::V1::BaseController
  before_action :set_question, only: [:index, :create]
  before_action :set_answer, only: :show

  # authorize_resource

  def index
    respond_with @question.answers
  end

  def create
    @answer = @question.answers.build(answers_params)
    @answer.user = current_resource_owner
    @answer.save
    respond_with @answer
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

  def answers_params
    params.require(:answer).permit(:body)
  end
end