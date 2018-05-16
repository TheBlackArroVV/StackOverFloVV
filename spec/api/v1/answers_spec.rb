require 'rails_helper.rb'

describe 'Answer API' do
  describe 'GET /index' do
    it_behaves_like "API Authenticable"

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

    def do_request(options = {})
      get '/api/v1/answers', params: { format: :json }.merge(options)
    end
  end

  describe 'GET /show' do
    it_behaves_like "API Authenticable"

    context 'authorized' do
      let(:access_token) { create :access_token }
      let!(:user) { create :user }
      let!(:question) { create :question, user: user }
      let!(:answer) { create(:answer, question: question, user: user) }
      let!(:comment) { create(:comment, commentable: answer, user: user) }
      let!(:attachment) { create(:attachment, attachable: answer) }

      before { get '/api/v1/answers', params: { format: :json, access_token: access_token.token, id: answer.question_id } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      %w(id body created_at updated_at).each do |attr|
        it "comment object contains #{attr}" do
          expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("0/comments/0/#{attr}")
        end
      end

      it "attachment object contains file" do
        expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("0/attachments/0/file")
      end
    end

    def do_request(options = {})
      get '/api/v1/answers', params: { format: :json }.merge(options)
    end
  end

  describe 'POST /create' do
    let!(:do_request) { post '/api/v1/answers', params: { format: :json } }
    let!(:do_request_with_token) { post '/api/v1/answers', params: { format: :json, access_toke: '1234' } }

    it_behaves_like "API Authenticable"

    context 'authorized' do
      let!(:access_token) { create :access_token }
      let!(:question) { create :question, user: User.last }
      let!(:answer) { create :answer, user: User.last, question: question }

      before { post '/api/v1/answers', params: { format: :json, id: question.id, access_token: access_token.token, answer: { body: answer.body } } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      %w(body user_id).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end

      it 'should save question to db' do
        expect { post '/api/v1/answers', params: { format: :json, access_token: access_token.token, id: question.id, answer: { body: answer.body } }}.to change(Answer, :count).by(1)
      end
    end

    def do_request(options = {})
      post '/api/v1/answers', params: { format: :json }.merge(options)
    end
  end
end