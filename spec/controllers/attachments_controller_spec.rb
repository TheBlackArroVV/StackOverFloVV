require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  login_user
  let(:question) { create :question, user: @user }
  let(:answer) { create :answer, user: @user, question: question }
  let(:attachment) { create :attachment, attachable: question }

  describe 'DELETE #destroy' do
    it 'should delete question from db' do
      question
      expect { delete :destroy, params: { id: attachment } }.to change(Attachment, :count).by(-1)
    end
    it 'should redirect to questions' do
      delete :destroy, params: { id: attachment }
      expect(response).to redirect_to questions_path
    end
  end
end