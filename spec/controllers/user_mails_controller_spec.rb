require 'rails_helper'

RSpec.describe UserMailsController, type: :controller do
  login_user
  let!(:question) { create :question, user: @user }
  let!(:answer) { create :answer, question: question, user: @user }

  describe 'POST #subscribe_to question' do
    before { post :create, params: { id: question } }

    it 'should assign question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'should change UserMail count' do
      expect { post :create, params: { id: question } }.to change(UserMail, :count).by(1)
    end
  end

  describe 'DELETE #unsubscribe_from_question' do
    let!(:user_mail) { create :user_mail, user: @user, question: question }

    it 'should change UserMail count' do
      expect { delete :destroy, params: { id: question } }.to change(UserMail, :count).by(-1)
    end

    it 'should redirect_to question' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to(question_path(question))
    end
  end
end
