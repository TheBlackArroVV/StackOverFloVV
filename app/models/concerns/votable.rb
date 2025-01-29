module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def sum_of_votes
    self.votes.sum(:score)
  end
end