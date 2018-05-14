class QuestionsMailer < ApplicationMailer
  def new_answer(question)
    @answer = question.answers.last

    mail(to: question.user.email, subject: 'New Answer')
  end

  def subscribed_question(question, user)
    @question = question

    mail(to: user.email, subject: 'Subscribed Question')
  end
end
