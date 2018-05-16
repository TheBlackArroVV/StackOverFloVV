shared_examples_for "API Authenticable" do
  context 'anuthorized' do
    it 'returns 401 if request without access token' do
      do_request

      expect(response.status).to eq 401
    end

    it 'returns if access token not valid' do
      do_request(access_token: '1234')

      expect(response.status).to eq 401
    end
  end
end