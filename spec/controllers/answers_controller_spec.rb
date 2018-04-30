require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'POST #create' do
    login_user
    let(:question) { create :question, user: @user }
    let(:answer) { create :answer, user: @user, question: question }
    context 'signed in user try to write a answer' do

      before do
        post :create, params: { answer: attributes_for(:answer), question_id: question, user_id: @user, format: :js }
      end
      it 'should redirect_to answer' do
        expect(response).to redirect_to question_answers_path(question)
      end

      it 'should find a question to be attached' do
        expect(assigns(:question)).to eq question
      end

      context 'valid data' do
        it 'should create a new answer', js: true  do
          expect { Answer.create(body: attributes_for(:answer), question_id: question.id, user_id: @user.id) }.to change(question.answers, :count).by(1)
        end
      end

      context 'invalid data' do
        it 'should not save a answer' do
          expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question, user_id: @user, format: :js } }.not_to change(Answer, :count)
        end
      end
    end

    context 'not loged user try to write a answer' do

      it 'should redirect_to login' do
        sign_out @user

        post :create, params: { answer: attributes_for(:answer), question_id: question }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
