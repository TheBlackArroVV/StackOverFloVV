require_relative 'acceptance_helper'

feature 'Add files to answers' do
  given(:user) { create :user }
  given(:question) { create :question, user: user }

  background do
    user_authentication(user)
    visit question_path(question)
  end

  scenario 'User adds file to the question', js: true do
    fill_in 'answer_body', with: 'Body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_link'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end