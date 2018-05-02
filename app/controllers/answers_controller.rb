class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_question, only: :create
  before_action :set_answer, only: :destroy

  def create
    @answer = @question.answers.new(answer_params)
    flash[:notice] = 'You need to sign in or sign up before continuing.' if !current_user
    @answer.user = current_user
    @answer.save
  end

  def destroy
    @answer.destroy
    flash[:notice] = 'Your answer was deleted'
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :body, :user_id)
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
