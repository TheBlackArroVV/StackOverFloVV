require 'rails_helper'

RSpec.describe NewAnswerJob, type: :job do
  let(:user) { create :user }
  let!(:question) { create :question, user: user }
  let!(:answer) { create :answer, question: question, user: user }

  it 'should perform delivery' do
    allow(QuestionsMailer).to receive(:new_answer).with(question).and_call_original
    NewAnswerJob.perform_now(question)
  end
end
