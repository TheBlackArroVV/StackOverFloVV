require 'rails_helper'

RSpec.describe DigestJob, type: :job do
  let(:user) { create :user }

  it 'should perform delivery' do
    allow(DailyMailer).to receive(:digest).with(user).and_call_original
    DigestJob.perform_now
  end
end
