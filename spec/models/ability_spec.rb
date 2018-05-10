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

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    it { should be_able_to :create, Attachment }

    it { should be_able_to :update, question, user: user }
    it { should_not be_able_to :update, other_question, user: user }

    it { should be_able_to :update, answer, user: user }
    it { should_not be_able_to :update, other_answer, user: user }

    it { should be_able_to :delete, question, user: user }
    it { should_not be_able_to :delete, other_question, user: user }

    it { should be_able_to :delete, answer, user: user }
    it { should_not be_able_to :delete, other_answer, user: user }

    it { should be_able_to :delete, attachment }
  end
end