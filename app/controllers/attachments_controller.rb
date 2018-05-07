class AttachmentsController < ApplicationController
  before_action :set_attachment, :destroy

  respond_to :js

  def destroy
    @question = @attachment.set_question
    respond_with(@attachment.destroy)
  end

  private

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end
end
