require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    login_user
    let(:question) { create :question, user: @user }
    let(:answer) { create :answer, user: @user, question: question }
    let(:comment) { create :comment, user: @user, commentable_type: 'Question', commentable_id: question.id }
    let(:invalid_comment) { create :comment }

    context 'signed in user try to write a comment' do
      before do
        post :create, params: { comment: attributes_for(:comment), commentable_type: 'Question', commentable_id: question.id, user_id: @user, format: :js }
      end

      context 'valid data' do
        it 'should create a new comment', js: true do
          expect { Comment.create(body: attributes_for(:comment), commentable_id: question.id, commentable_type: 'Question', user_id: @user.id) }.to change(question.comments, :count).by(1)
        end
      end

      context 'invalid data' do
        it 'should not save a comment' do
          expect { post :create, params: { comment: attributes_for(:invalid_comment), commentable_type: 'Question', commentable_id: question.id, user_id: @user, format: :js } }.not_to change(Comment, :count)
        end
      end
    end

    context 'not loged user try to write a comment' do
      it 'should redirect_to login' do
        sign_out @user

        post :create, params: { comment: attributes_for(:comment), commentable_id: question.id, commentable_type: 'Question', user_id: @user }

        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
