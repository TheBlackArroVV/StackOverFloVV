class Answer < ApplicationRecord
  validates :body, presence: true

  belongs_to :question
  belongs_to :user

  scope :best, -> { order('best_answer desc') }

  def make_best
    previous_best = self.question.answers.where(best_answer: true).first
    if previous_best
      previous_best.best_answer = false
      previous_best.save
    end
    self.best_answer = true
    self.save
    self.question.answers
  end
end
