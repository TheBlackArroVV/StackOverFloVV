require 'spec_helper.rb'

shared_examples_for 'voted' do
  context 'POST #like' do
    before do
      post :like, params: { id: votable_id, format: 'json' }
    end

    it 'should create new vote' do
      expect(assigns(:vote).score).to eq 1
    end

    it 'should take score to 1' do
      expect(assigns(:vote).score).to eq 1
    end
  end

  context 'POST #dislike' do
    before do
      post :dislike, params: { id: votable_id, format: 'json' }
    end

    it 'should create new vote' do
      expect(assigns(:vote).score).to eq -1
    end

    it 'should take score to -1' do
      expect(assigns(:vote).score).to eq -1
    end
  end

  context 'DELETE #unvote' do

    it 'should delete vote from db' do
      expect { delete :unvote, params: { id: unvotable_id }, format: :json }.to change(Vote, :count).by(-1)
    end
  end
end