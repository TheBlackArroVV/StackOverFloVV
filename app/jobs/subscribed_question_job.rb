class SubscribedQuestionJob < ApplicationJob
  queue_as :default

  def perform(question)
    question.user_mails.each do |user_mail|
      QuestionsMailer.subscribed_question(question, user_mail.user).deliver_now
    end
  end
end
