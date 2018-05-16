require 'rails_helper'

RSpec.describe SubscribedQuestionJob, type: :job do
  let(:user) { create :user }
  let!(:question) { create :question, user: user }

  it 'should perform delivery' do
    allow(QuestionsMailer).to receive(:subscribed_question).with(question).and_call_original
    SubscribedQuestionJob.perform_now(question)
  end
end
