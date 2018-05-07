class AttachmentsController < ApplicationController
  before_action :set_attachment, :destroy

  respond_to :js

  def destroy
    respond_with(@attachment.destroy)
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
    @question = @attachment.set_question
  end
end
