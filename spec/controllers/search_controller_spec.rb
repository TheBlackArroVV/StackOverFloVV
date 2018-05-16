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

    before do
      ThinkingSphinx::Test.index
      ThinkingSphinx::Test.start

      post :index, params: { search_type: "Question", body: { body: "MyString" } }
    end

    it 'should render index' do
      expect(response).to render_template :index
    end

    it 'should return question', sphinx: true do
      expect(assigns(:result)[Question].first).to eq(question)
    end
  end
end
