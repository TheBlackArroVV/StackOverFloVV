class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment

  after_action :publish_comment

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @commentable
    @comment.save
  end

  private

  def model
    params[:commentable_type].classify.constantize
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  def set_comment
    @commentable = model.find(params[:commentable_id])
  end

  def publish_comment
    return if @comment.errors.any?
    pp @comment
    ActionCable.server.broadcast 'comments', @comment
  end
end
