require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability){ Ability.new(user) }

  describe 'quest can' do
    let(:user) { nil }

    it { should be_able_to :read, :all }

    it { should_not be_able_to :manage, :all }
  end

  describe 'user can' do
    let(:user) { create :user }
    let(:other_user) { create :user }
    let(:question) { create :question, user: user }
    let(:other_question) { create :question, user: other_user }
    let(:answer) { create :answer, user: user, question: question }
    let(:other_answer) { create :answer, user: other_user, question: question }
    let(:comment) { create :comment, user: user, commentable: question }
    let(:other_comment) { create :comment, user: other_user, commentable: question }
    let(:attachment) { create :attachment, attachable: question }

    it { should be_able_to :manage, Attachment }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, question, user: user }
    it { should_not be_able_to :update, other_question, user: user }

    it { should be_able_to :update, answer, user: user }
    it { should_not be_able_to :update, other_answer, user: user }

    it { should be_able_to :destroy, question, user: user }
    it { should_not be_able_to :destroy, other_question, user: user }

    it { should be_able_to :destroy, answer, user: user }
    it { should_not be_able_to :destroy, other_answer, user: user }

    it { should be_able_to :choose_best, answer, user: user }
    it { should_not be_able_to :choose_best, other_answer, user: user }

    it { should be_able_to :like, other_answer, user: user }
    it { should be_able_to :dislike, other_answer, user: user }
    it { should be_able_to :unvote, other_answer, user: user }

    it { should_not be_able_to :like, answer, user: user }
    it { should_not be_able_to :dislike, answer, user: user }
    it { should_not be_able_to :unvote, answer, user: user }

    it { should be_able_to :like, other_question, user: user }
    it { should be_able_to :dislike, other_question, user: user }
    it { should be_able_to :unvote, other_question, user: user }

    it { should_not be_able_to :like, question, user: user }
    it { should_not be_able_to :dislike, question, user: user }
    it { should_not be_able_to :unvote, question, user: user }

  end
end
