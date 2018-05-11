require 'rails_helper.rb'

describe 'Question API' do
  context 'anuthorized' do
    it 'returns 401 if request without access token' do
      get '/api/v1/questions', params: { format: :json }

      expect(response.status).to eq 401
    end

    it 'returns if access token not valid' do
      get '/api/v1/questions', params: { format: :json, access_token: '1234' }

      expect(response.status).to eq 401
    end
  end

  describe 'GET /show' do
    context 'authorized' do
      let(:access_token) { create :access_token }
      let!(:user) { create :user }
      let!(:question) { create :question, user: user }
      let!(:answer) { create(:answer, question: question, user: user) }
      let!(:other_answer) { create(:answer, question: question, user: user) }

      before { get '/api/v1/answers', params: { format: :json, access_token: access_token.token, id: question.id } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'returns list' do
        expect(response.body).to have_json_size(2)
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end
  end
end