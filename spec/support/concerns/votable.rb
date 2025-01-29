require 'spec_helper.rb'

shared_examples_for 'votable' do
  it { should have_many :votes }
end