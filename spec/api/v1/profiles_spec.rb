require 'rails_helper.rb'

describe 'Profile API' do
  describe 'GET /me' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:me) { create :user }
      let(:access_token) { create :access_token, resource_owner_id: me.id }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      %w(id email created_at updated_at).each do |attr|
        it "contains #{attr}" do
          expect(response.body).to be_json_eql(me.send("#{attr}").to_json).at_path(attr)
        end
      end

      %w(password encrypted_password).each do |attr|
        it "not contains #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/me', params: { format: :json }.merge(options)
    end
  end

  describe 'GET /users' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:me) { create :user }
      let!(:users) { create_list(:user, 2) }
      let(:access_token) { create :access_token, resource_owner_id: me.id }

      before { get '/api/v1/profiles/users', params: { format: :json, access_token: access_token.token } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'return all other users' do
        expect(response.body).to eq(users.to_json)
      end

      %w(me.email me.id).each do |attr|
        it "not contains #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    def do_request(options = {})
      get '/api/v1/profiles/users', params: { format: :json }.merge(options)
    end
  end
end
