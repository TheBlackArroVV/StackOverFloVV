require_relative 'acceptance_helper'

feature 'Add files to answers' do
  given(:user) { create :user }
  given(:question) { create :question, user: user }

  background do
    user.confirm
    user_authentication(user)
    visit question_path(question)
  end

  scenario 'User adds file to the question', js: true do
    fill_in 'answer_body', with: 'Body'
    click_on 'add file'
    attach_file 'File', "#{Rails.root}/spec/files/test_file1.txt"
    click_on 'Create answer'

    within '.answers' do
      expect(page).to have_link 'test_file1.txt', href: '/uploads/attachment/file/1/test_file1.txt'
    end
  end
end
