class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :set_question, only: :show

  # authorize_resource
  skip_authorization_check
  def index
    @questions = Question.all
    respond_with @questions
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_resource_owner
    @question.save
    respond_with @question
  end

  def show
    respond_with @question
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
