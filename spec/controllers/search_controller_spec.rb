require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'should render index' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #index' do
    let!(:user) { create :user }
    let!(:question) { create :question, user: user }
    let(:answer) { create :answer, user: @user, question: question }
    let(:comment) { create :comment, user: @user, commentable_type: 'Question', commentable_id: question.id }

    before { post :index, params: { search_type: "Question", body: { body: "MyString" } } }

    it 'should render index' do
      expect(response).to render_template :index
    end

    it 'should return question' do
      allow(Question).to receive(:search).with("MyString")
      post :index, params: { search_type: "Question", body: { body: "MyString" } }
      # post :index, params: { search_type: 'Question', body: { body: 'MyString' } }
      # pp question
      # pp Question.all
      # a = assigns(:result)
      # expect(assigns(:result)).to eq(question)
    end
  end
end
