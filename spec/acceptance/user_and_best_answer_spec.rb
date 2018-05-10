# frozen_string_literal: true

require_relative 'acceptance_helper.rb'

feature 'User and best answer' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given!(:answer) { create :answer, user: user, question: question }

  before do
    user.confirm
    new_user.confirm
  end

  scenario 'unloged user try to choose a best answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Make this answer best'
  end

  scenario 'loged user(not author) try to choose a best answer', js: true do
    user_authentication(new_user)
    visit question_path(question)

    expect(page).to_not have_content 'Make this answer best'
  end

  scenario 'author try to choose a best answer', js: true do
    user_authentication(user)
    visit question_path(question)
    click_on 'Make this answer best'

    expect(page).to have_content 'Best answer'
  end
end
