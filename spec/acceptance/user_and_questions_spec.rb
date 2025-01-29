require 'acceptance/acceptance_helper'

feature 'User and questions' do
  given(:user) { create :user }
  given(:question) { create :question }
  given!(:answer) { create :answer, question: question }

  before do
    user.confirm
  end

  describe 'loged user try to create question' do
    scenario 'user create a question' do
      user_authentication(user)
      create_question

      expect(page).to have_content 'NewTitle'
    end

    scenario 'user answer a question', js: true do
      user_authentication(user)
      create_question
      create_answer('AnswerBody')

      within '.answers' do
        expect(page).to have_content 'AnswerBody'
      end
    end

    scenario 'user try to create blank answer', js: true do
      user_authentication(user)
      create_question
      click_on 'Create answer'

      expect(page).to have_content "Body can't be blank"
    end
  end

  describe 'unregistred user try to create question' do
    scenario 'user create a question' do
      visit new_question_path

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    scenario 'user answer a question' do
      visit question_path(question)
      create_answer('AnswerBody')

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end

  scenario 'user see questions' do
    visit questions_path

    expect(page).to have_content @questions
  end

  fcontext 'action cable tests' do
    scenario 'multiply sessions', js: true do
      Capybara.using_session('user') do
        user_authentication(user)
        visit questions_path
      end

      Capybara.using_session('quest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        visit new_question_path

        fill_in 'Title', with: 'NewTitle'
        fill_in 'Body', with: 'NewBody'

        click_on 'Create question'
        expect(page).to have_content 'NewTitle'
      end

      Capybara.using_session('quest') do
        expect(page).to have_content 'NewTitle'
      end
    end
  end

  scenario 'user can watch question and answers for question' do
    user_authentication(user)
    create_question
    visit questions_path
    click_on question.title

    expect(page).to have_content 'MyString'
    within '.answers' do
      expect(page).to have_content 'MyAnswer'
    end
  end
end
