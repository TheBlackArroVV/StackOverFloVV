class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!, only: [:create]
  before_action :set_question, only: :create
  before_action :set_answer, only: %i[destroy update choose_best]

  after_action :publish_answer, only: [:create]

  def create
    @answer = @question.answers.new(answer_params)
    flash[:notice] = 'You need to sign in or sign up before continuing.' unless current_user
    @answer.user = current_user
    @answer.save
    if params[:answer]
      @answer.attachments.build if params[:answer][:attachments_attributes]
    end
  end

  def update
    @question = @answer.question
    @answer.update(answer_params)
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Your answer was deleted'
    redirect_to @answer.question
  end

  def choose_best
    @question = @answer.question
    @answer.make_best
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body, :user_id, attachments_attributes: [:file])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def publish_answer
    return if @answer.errors.any?
    # mock_env = Rack::MockRequest.env_for('/')
    # catch(:env) do
    #   Rails.application.middleware.build(lambda { |env|
    #     throw :env, env
    #   }).call mock_env
    # end
    # mock_env["warden"]
    ActionCable.server.broadcast(
      'answers',
      ApplicationController.render(
        partial:'answers/answer',
        locals: { answer: @answer },
        assigns: { env: {"HTTP_HOST"=>"localhost:3000",
                        "HTTPS"=>"off",
                        "REQUEST_METHOD"=>"GET",
                        "SCRIPT_NAME"=>"",
                        "warden" => warden}
        }
      )
    )
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
