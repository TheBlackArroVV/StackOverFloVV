require 'rails_helper'

RSpec.describe UserMail, type: :model do
  it { should belong_to :user }
  it { should belong_to :question }
end
