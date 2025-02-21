class Answer < ApplicationRecord
  include Votable
  include Commentable

  has_many :attachments, as: :attachable

  belongs_to :question
  belongs_to :user

  after_create :send_notice

  accepts_nested_attributes_for :attachments

  validates :body, presence: true

  scope :best, -> { order('best_answer desc') }

  def make_best
    previous_best = question.answers.where(best_answer: true).first
    if previous_best
      previous_best.best_answer = false
      previous_best.save
    end
    self.best_answer = true
    save
    question.answers
  end

  private

  def send_notice
    NewAnswerJob.perform_later(question)
  end
end
