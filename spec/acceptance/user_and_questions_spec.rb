# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'User and questions' do
  given(:user) { create :user }
  given(:question) { create :question }
  given!(:answer) { create :answer, question: question }

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
