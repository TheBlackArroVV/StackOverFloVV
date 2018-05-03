class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validate :uniq_vote, on: :create
  validates :score, presence: true
  validates :score, uniqueness: { scope: [:votable_id, :votable_type, :user_id] }

  def uniq_vote
    vote = Vote.find_by(votable_id: votable_id, score: -score) if score
    if vote
      errors[:score] << 'Delete your vote first'
    end
  end
end
