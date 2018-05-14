require 'rails_helper'

RSpec.describe Question, type: :model do
  it_behaves_like 'votable'

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should have_many :answers }
  it { should have_many :attachments }
  it { should have_many :votes }
  it { should have_many :user_mails }

  it { should belong_to :user }

  it { should accept_nested_attributes_for :attachments }

  describe 'subscribed question' do
    let(:user) { create :user }
    let(:new_user) { create :user }
    let!(:question) { create :question, user: user }

    it 'should deliver message about updating question' do
      expect(question).to receive(:subscribed_notification)
      question.update(title: 'New Title')
    end
  end
end
