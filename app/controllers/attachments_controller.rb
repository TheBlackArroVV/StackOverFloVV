class AttachmentsController < ApplicationController
  before_action :set_attachment, :destroy

  # authorize_resource
  skip_authorization_check

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
