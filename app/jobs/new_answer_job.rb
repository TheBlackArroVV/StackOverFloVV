class NewAnswerJob < ApplicationJob
  queue_as :default

  def perform(question)
    question.user_mails.each do |user_mail|
      QuestionsMailer.new_answer(question, user_mail.user).deliver_now
    end
  end
end
