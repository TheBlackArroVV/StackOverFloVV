class UserMailsController < ApplicationController
  before_action :set_question
  authorize_resource

  def create
    @user_mail = @question.user_mails.new
    @user_mail.user = current_user
    @user_mail.save
    redirect_to @question
  end

  def destroy
    @user_mail = UserMail.find_by(question: @question, user: current_user)
    @user_mail.destroy
    redirect_to @question
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end
