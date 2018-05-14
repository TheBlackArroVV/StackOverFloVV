class QuestionsMailer < ApplicationMailer
  def new_answer(question, user)
    @answer = question.answers.last

    mail(to: user.email, subject: 'New Answer')
  end

  def subscribed_question(question, user)
    @question = question

    mail(to: user.email, subject: 'Subscribed Question')
  end
end
