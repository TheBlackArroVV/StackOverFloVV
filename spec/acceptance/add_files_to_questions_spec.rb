# frozen_string_literal: true

require_relative 'acceptance_helper.rb'

feature 'Add Files to questions' do
  given(:user) { create :user }

  background do
    user_authentication(user)
    visit new_question_path
  end

  scenario 'User adds file to the question', js: true do
    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'Body'
    click_on 'Add a attachment'
    attach_file 'File', "#{Rails.root}/spec/files/test_file1.txt"
    click_on 'Create'

    expect(page).to_not have_link 'test_file1.txt', href: '/uploads/attachment/file/1/test_file.txt'
  end
end
