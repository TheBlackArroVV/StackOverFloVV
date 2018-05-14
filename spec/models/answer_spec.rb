require 'rails_helper'

RSpec.describe Answer, type: :model do
  it_behaves_like 'votable'

  it { should validate_presence_of :body }
  it { should have_many :attachments }
  it { should have_many :votes }

  it { should belong_to :user }
  it { should belong_to :question }

  it { should accept_nested_attributes_for :attachments }


  describe 'notice' do
    let(:user) { create :user }
    let(:new_user) { create :user }
    let!(:question) { create :question, user: user }

    it 'should deliver message about new answer' do
      expect(NewAnswerJob).to receive(:perform_later).with(question)
      create :answer, question: question, user: new_user
    end
  end
end
