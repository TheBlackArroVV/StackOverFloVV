require_relative 'acceptance_helper'

feature 'user and comments' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given(:new_question) { create :question, user: user }
  given!(:answer) { create :answer, user: user, question: question }
  given!(:comment) { create :comment, user: user, commentable_id: question.id, commentable_type: 'Question' }
  given!(:answer_comment) { create :comment, user: user, commentable_id: answer.id, commentable_type: 'Answer' }

  fcontext 'action cable tests' do
    scenario 'multiply sessions for comment question', js: true do
      Capybara.using_session('user') do
        user_authentication(user)
        visit question_path(new_question)
      end

      Capybara.using_session('quest') do
        visit question_path(new_question)
      end

      Capybara.using_session('user') do
        within '.question_comment_form' do
          fill_in 'comment_body', with: 'Comment'
          click_on 'Create a comment'
        end

        within '.question_comments' do
          expect(page).to have_content 'Comment'
        end
      end

      Capybara.using_session('quest') do
        within '.question_comments' do
          expect(page).to have_content 'Comment'
        end
      end
    end

    scenario 'multiply sessions for comment answer', js: true do
      Capybara.using_session('user') do
        user_authentication(user)
        visit question_path(question)
      end

      Capybara.using_session('quest') do
        visit question_path(question)
      end

      Capybara.using_session('user') do
        visit question_path(question)

        within '.answer_comment_form' do
          fill_in 'comment_body', with: 'Comment'
          click_on 'Create a comment'
        end

        within '.answer_1_comments' do
          expect(page).to have_content 'Comment'
        end
      end

      Capybara.using_session('quest') do
        within '.answer_1_comments' do
          expect(page).to have_content 'Comment'
        end
      end
    end
  end

  context 'user and question comments' do
    scenario 'all users can see comments', js: true do
      visit question_path(question)

      within '.question_comments' do
        expect(page).to have_content 'Comment'
      end
    end

    scenario 'unloged user try to comment for question', js: true do
      visit question_path(question)

      expect(page).to_not have_content 'Create a comment'
    end

    scenario 'loged user try to сomment for question', js: true do
      user_authentication(new_user)
      visit question_path(new_question)
      within '.question_comment_form' do
        fill_in 'comment_body', with: 'Comment'
        click_on 'Create a comment'
      end

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

      expect(page).to_not have_content 'Create a comment'
    end

    scenario 'loged user try to сomment for answer', js: true do
      user_authentication(new_user)
      visit question_path(question)
      within '.answer_comment_form' do
        fill_in 'comment_body', with: 'Comment'
        click_on 'Create a comment'
      end

      within '.answer_1_comments' do
        expect(page).to have_content 'Comment'
      end
    end
  end
end