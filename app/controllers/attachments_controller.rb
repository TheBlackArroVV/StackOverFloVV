class AttachmentsController < ApplicationController
  before_action :set_attachment, :destroy

  def destroy
    @question = @attachment.set_question
    @attachment.destroy
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end