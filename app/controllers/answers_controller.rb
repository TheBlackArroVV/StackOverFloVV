class AnswersController < ApplicationController
  include Voted

  before_action :authenticate_user!, only: [:create]
  before_action :set_question, only: :create
  before_action :set_answer, only: %i[destroy update choose_best]

  after_action :publish_answer, only: [:create]

  authorize_resource

  respond_to :js

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    if params[:answer]
      @answer.attachments.build if params[:answer][:attachments_attributes]
    end
    gon.question_id = @answer.question.id
    respond_with(@answer)
  end

  def update
    @answer.update(answer_params)
    respond_with(@answer)
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Your answer was deleted'
    redirect_to @answer.question
  end

  def choose_best
    respond_with(@answer.make_best)
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body, :user_id, attachments_attributes: [:file])
  end

  def set_answer
    @answer = Answer.find(params[:id])
    @question = @answer.question
  end

  def publish_answer
    return if @answer.errors.any?
    pp @answer
    ActionCable.server.broadcast "questions/#{@answer.question_id}/answers", @answer.as_json.merge({sum: @answer.sum_of_votes})
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end