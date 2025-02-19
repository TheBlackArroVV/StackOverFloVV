require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  context 'HTTP' do
    login_user
    let!(:question) { create :question, user: @user }
    let!(:vote) { create :vote, user: @user, votable: question }
    let!(:votable_id) { question.id }
    let!(:unvotable_id) { question.id }
    it_behaves_like 'voted'

    let(:answer) { create :answer, user: @user, question: question }

    describe 'GET #index' do
      let(:questions) { create_list(:question, 2) }

      before { get :index }

      it 'should get all questions' do
        expect(assigns(:questions)).to match_array(Question.all)
      end
      it 'should render index' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: question } }

      it 'should assign a question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'should render show' do
        expect(response).to render_template :show
      end

      it 'should create a new answer' do
        expect { FactoryBot.create(:answer) }.to change(Answer, :count).by(1)
      end

      context 'subscribed check' do
        it 'should return false' do
          expect(assigns(:subscribed)).to eq nil
        end

        it 'should return true' do
          UserMail.create(user: @user, question: question)
          get :show, params: { id: question }
          expect(assigns(:subscribed)).to eq true
        end
      end
    end

    describe 'GET #new' do
      before do
        get :new
      end

      it 'should create a new question' do
        expect(assigns(:question)).to be_a_new(Question)
      end

      it 'should render new' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'valid data' do
        before do
          post :create, params: { question: attributes_for(:question), user_id: @user }
        end

        it 'should create a new Question' do
          expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
        end

        it 'should redirect to @question' do
          expect(response).to redirect_to question_path(Question.last)
        end
      end

      context 'invalid data' do
        it 'should not create a new Question' do
          expect { post :create, params: { question: attributes_for(:invalid_question) } }.not_to change(Question, :count)
        end

        it 'should render new' do
          post :create, params: { question: attributes_for(:invalid_question) }
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      it 'should assign requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to eq question
      end

      context 'valid data' do
        it 'should update question in  db' do
          patch :update, params: { id: question, question: attributes_for(:new_question), format: :js }
          question.reload
          expect(question.title).to eq 'new'
          expect(question.body).to eq 'new'
        end
      end

      context 'invalid data' do
        before { patch :update, params: { id: question, question: attributes_for(:invalid_question), format: :js } }

        it 'should don`t save data to db' do
          question.reload
          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'should delete question from db' do
        question
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'should redirect to questions' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
  end
end
