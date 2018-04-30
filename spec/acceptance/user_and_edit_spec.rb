require_relative 'acceptance_helper'

feature 'User and edit' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, user: user, question: question }

  context 'user and question edit' do
    scenario 'unloged user try to edit question', js: true do
      visit question_path(question)

      expect(page).not_to have_link 'Edit question'
    end

    scenario 'loged user(not author) try to edit question', js: true do
      user_authentication(new_user)
      visit question_path(question)

      expect(page).not_to have_link 'Edit question'
    end

    scenario 'author try to edit question', js: true do
      user_authentication(user)
      visit question_path(question)
      click_on 'Edit question'
      fill_in 'question_title', with: 'Edited title'
      click_on 'Update question'

      within '.question' do
        expect(page).to_not have_selector('input#question_body')
        expect(page).to have_content('Edited title')
      end
    end
  end

  context 'user and answer edit' do
    scenario 'unloged user try to edit answer' do
      visit question_path(question)

      expect(page).not_to have_link 'Edit answer'
    end

    scenario 'loged user(not author) try to edit answer' do
      user_authentication(new_user)
      visit question_path(question)

      expect(page).not_to have_link 'Edit answer'
    end

    scenario 'author try to edit answer', js: true do
      user_authentication(user)
      visit question_path(question)
      create_answer('answer')
      click_on 'Edit answer'
      within '.answers' do
        fill_in 'answer_body', with: 'Edited answer'
        click_on 'Update answer'

        expect(page).to have_content('Edited answer')
        expect(page).to_not have_selector('input#answer_body')
      end
    end
  end
end
