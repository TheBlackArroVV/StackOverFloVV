require 'rails_helper.rb'

describe 'Question API' do
  describe 'GET /index' do
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

    context 'authorized' do
      let(:access_token) { create :access_token }
      let!(:questions) { create_list(:question, 2) }

      before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'returns list' do
        expect(response.body).to have_json_size(2)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          question = questions.first
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end
    end
  end
end
