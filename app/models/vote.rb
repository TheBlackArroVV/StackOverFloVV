class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :score, presence: true
  validates :score, uniqueness: { scope: [:votable_id, :votable_type, :user_id] }
end
