require_relative 'acceptance_helper'

feature 'Delete files from question' do
  given(:user) { create :user }
  given(:question) { create :question, user: user }

  background do
    user_authentication(user)
    visit question_path(question)
  end

  scenario 'delete file from question' do
    fill_in 'Title', with: 'Title'
    fill_in 'Body', with: 'Body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end