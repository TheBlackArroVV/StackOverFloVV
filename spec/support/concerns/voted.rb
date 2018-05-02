require 'spec_helper.rb'

shared_examples_for 'voted' do
  let(:user) { create :user }
  let!(:question) { create :question, user: user }
  let!(:answer) { create :answer, user: user, question: question }
  let!(:vote) { create :vote, user: user, votable: question }

  context 'POST #like' do
    before do
      post :like, params: { id: vote, format: 'json' }
    end

    it 'should create new vote' do
      expect(assigns(:vote).score).to eq 1
      expect(assigns(:vote).votable_id).to eq 1
    end

    it 'should take score to 1' do
      expect(assigns(:vote).score).to eq 1
    end
  end

  context 'POST #dislike' do
    before do
      post :dislike, params: { id: vote, format: 'json' }
    end

    it 'should create new vote' do
      expect(assigns(:vote).score).to eq -1
      expect(assigns(:vote).votable_id).to eq 1
    end

    it 'should take score to -1' do
      expect(assigns(:vote).score).to eq -1
    end
  end

  context 'DELETE #unvote' do
    it 'should delete vote from db' do
      expect { delete :unvote, params: { id: vote, format: :js }, format: :json }.to change(Vote, :count).by(-1)
    end
  end
end