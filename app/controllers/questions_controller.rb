class QuestionsController < ApplicationController
  include Voted

  before_action :authenticate_user!, only: %i[new update create destroy]
  before_action :set_question, only: %i[show update destroy subscribe_to_question]

  after_action :publish_question, only: [:create]

  authorize_resource

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      flash[:notice] = 'Your question create'
      redirect_to @question
    else
      render :new
    end
  end

  def show
    @answer = @question.answers.build
    @answers = @question.answers
    gon.question_id = @question.id
    if params[:answer]
      @answer.attachments.build if params[:answer][:attachments_attributes]
    end
  end

  def destroy
    respond_with(@question.destroy)

  end

  def update
    @question.update(question_params)
  end

  def subscribe_to_question
    @user_mail = @question.user_mails.new
    @user_mail.user = current_user
    @user_mail.save
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
