require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  login_user
  let(:question) { create :question, user: @user }
  let(:answer) { create :answer, user: @user, question: question }
  let!(:attachment) { create :attachment, attachable: question }

  describe 'DELETE #destroy' do
    it 'should delete attachment from db' do
      expect { delete :destroy, params: { id: attachment, format: :js } }.to change(Attachment, :count).by(-1)
    end
  end
end
