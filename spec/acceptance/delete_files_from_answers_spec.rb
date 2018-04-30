require_relative 'acceptance_helper'

feature 'Delete files from answers' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, question: question user: user }

  background do
    user_authentication(new_user)
    visit question_path(question)
  end

  scenario 'delete file from question' do
    fill_in 'Body', with: 'Body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create answer'

    expect(page).to have_link'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end