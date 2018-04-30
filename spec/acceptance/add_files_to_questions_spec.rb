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
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
