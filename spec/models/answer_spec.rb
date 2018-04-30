require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it 'should check relation with question' do
    expect(Answer.new(body: 'body')).not_to be_valid
  end
end
