require 'acceptance/acceptance_helper'

feature 'User delete questions and answers' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question }
  given!(:answer) { create :answer, question: question }
  scenario 'User try to delete her question' do
    user_authentication(user)
    create_question
    click_on 'Delete question'

    expect(page).to have_content 'Your question was deleted'
  end

  scenario 'User try to delete her answer', js: true do
    user_authentication(user)
    visit question_path(question)
    create_answer('AnswerBody')
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer was deleted'
  end

  scenario 'User try to delete alien question' do
    visit question_path(question)

    expect(page).not_to have_content 'Delete question'
  end

  scenario 'User try to delete alien answer', js: true do
    user_authentication(new_user)

    visit question_path(question)
    expect(page).not_to have_content 'Delete answer'
  end
end