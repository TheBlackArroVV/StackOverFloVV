class NewAnswerJob < ApplicationJob
  queue_as :default

  def perform(question)
    QuestionsMailer.new_answer(question).deliver_now
  end
end
