# frozen_string_literal: true

require_relative 'acceptance_helper'

feature 'Delete files from answers' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, question: question, user: user }

  background do
    user_authentication(new_user)
    visit question_path(question)
  end

  scenario 'delete file from answer', js: true do
    fill_in 'answer_body', with: 'Body'
    attach_file 'File', "#{Rails.root}/spec/files/test_file1.txt"
    click_on 'Create answer'
    click_on 'Delete attachment'

    expect(page).to_not have_link 'test_file1.txt', href: '/uploads/attachment/file/1/test_file1.txt'
  end
end
