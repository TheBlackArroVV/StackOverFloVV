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

  describe 'GET /index' do
    context 'authorized' do
      let(:access_token) { create :access_token }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:user) { create :user }
      let!(:answer) { create(:answer, question: question, user: user) }

      before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token } }

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'returns list' do
        expect(response.body).to have_json_size(2)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'answers' do
        it 'included in question' do
          expect(response.body).to have_json_size(1).at_path("0/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end
    end
  end

  describe 'GET /show' do
    let(:access_token) { create :access_token }
    let!(:user) { create :user }
    let!(:question) { create :question }
    let!(:answer) { create(:answer, question: question, user: user) }
    let!(:attachment) { create(:attachment, attachable: question) }
    let!(:comment) { create(:comment, user_id: user.id, commentable: question) }

    before { get '/api/v1/questions', params: { format: :json, access_token: access_token.token, id: question.id } }

    it 'returns 200' do
      expect(response).to be_successful
    end

    %w(id title body created_at updated_at user_id).each do |attr|
      it "question object contains #{attr}" do
        expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
      end
    end

    context 'answers' do
      it 'included in question' do
        expect(response.body).to have_json_size(1).at_path("0/answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
        end
      end
    end

    context 'attachments' do
      it 'included in question' do
        expect(response.body).to have_json_size(1).at_path("0/attachments")
      end

      %w(file).each do |attr|
        it "attachment object contains #{attr}" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("0/attachments/0/#{attr}")
        end
      end
    end

    context 'comments' do
      it 'included in question' do
        expect(response.body).to have_json_size(1).at_path("0/comments")
      end

      %w(id body user_id).each do |attr|
        it "comment object contains #{attr}" do
          expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("0/comments/0/#{attr}")
        end
      end
    end
  end
end
