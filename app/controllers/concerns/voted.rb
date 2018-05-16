module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_vote, only: [:like, :dislike, :unvote]
  end

  def like
    @vote = @votable.votes.build(user: current_user, score: 1)

    respond_to do |format|
      if @vote.save
        format.json { render json: @votable.votes.sum(:score) }
      else
        format.json { render json: @vote.errors.full_messages, status: 422 }
      end
    end
  end

  def dislike
    @vote = @votable.votes.build(user: current_user, score: -1)

    respond_to do |format|
      if @vote.save
        format.json { render json: @votable.votes.sum(:score) }
      else
        format.json { render json: @vote.errors.full_messages, status: 422 }
      end
    end
  end

  def unvote
    @votable.votes.where(user: current_user).delete_all
    respond_to do |format|
      format.json { render json: @votable.votes.sum(:score) }
    end
  end

  private

  def model
    controller_name.classify.constantize
  end

  def set_vote
    @votable = model.find(params[:id])
  end
end
