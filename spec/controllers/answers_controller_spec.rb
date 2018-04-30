require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    let(:question) { create :question }
    let(:answer) { create :answer }

    before { post :create, params: { answer: attributes_for(:answer), question_id: question } }

    it 'should redirect_to answer' do
      expect(response).to redirect_to question_path(assigns(:question))
    end

    it 'should find a question to be attached' do
      expect(assigns(:question)).to eq question
    end

    context 'valid data' do
      it 'should create a new answer' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(Answer, :count).by(1)
      end
    end

    context 'invalid data' do
      it 'should not save a answer' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question } }.not_to change(Answer, :count)
      end
    end
  end
end
