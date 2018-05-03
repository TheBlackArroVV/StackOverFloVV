class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, only: %i[new update create destroy]
  before_action :set_question, only: %i[show update destroy]

  after_action :publish_question, only: [:create]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers
    if params[:answer]
      @answer.attachments.build if params[:answer][:attachments_attributes]
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy
    flash[:notice] = 'Your question was deleted'
    redirect_to questions_path
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/questions',
        locals: { question: @question }
      )
    )
  end

  def question_params
    params.require(:question).permit(:title, :body, :user_id, attachments_attributes: [:file])
  end
end
