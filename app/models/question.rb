class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :attachments, dependent: :destroy, as: :attachable
  has_many :user_mails

  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments

  after_update :subscribed_notification

  def subscribed_notification
    SubscribedQuestionJob.perform_now(self)
  end
end
