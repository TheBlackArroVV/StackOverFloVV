class QuestionsMailer < ApplicationMailer
  def new_answer(question)
    @answer = question.answers.last

    mail(to: question.user.email, subject: 'New Answer')
  end
end
