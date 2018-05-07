require_relative 'acceptance_helper'

feature 'user and comments' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given!(:answer) { create :answer, user: user, question: question }

  context 'user and question comments' do
    scenario 'all users can see comments', js: true do
      visit question_path(question)

      within '.question_comments' do
        expect(page).to have_content 'Comment'
      end
    end

    scenario 'unloged user try to comment for question', js: true do
      visit question_path(question)

      expect(page).to_not have_content 'Comment this question'
    end

    scenario 'loged user try to сomment for question', js: true do
      user_authentication(new_user)
      visit question_path(question)
      fill_in 'comment_body', with: 'Comment'
      click_on 'Comment this question'

      within '.question_comments' do
        expect(page).to have_content 'Comment'
      end
    end
  end

  context 'user and answers comments' do
    scenario 'all users can see comments', js: true do
      visit question_path(question)

      within '.answer_1_comments' do
        expect(page).to have_content 'Comment'
      end
    end

    scenario 'unloged user try to comment for answer', js: true do
      visit question_path(question)

      expect(page).to_not have_content 'Comment this answer'
    end

    scenario 'loged user try to сomment for answer', js: true do
      user_authentication(new_user)
      visit question_path(question)
      fill_in 'answer_1_comment_body', with: 'Comment'
      click_on 'Comment this question'

      within '.answer_1_comments' do
        expect(page).to have_content 'Comment'
      end
    end
  end
end