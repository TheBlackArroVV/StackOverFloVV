require_relative 'acceptance_helper'

feature 'search' do
  given!(:user) { create :user, nickname: 'test' }
  given!(:question) { create :question, title: 'test', user: user }
  given!(:answer) { create :answer, body: 'test', user: user, question: question }
  given!(:comment) { create :comment, body: 'test', user: user, commentable: question }

  scenario 'search user', sphinx: true do
    visit search_path

    select 'User', from: 'search_type'
    fill_in :body_body, with: user.nickname

    click_on 'Find'

    within '.users' do
      expect(page).to have_content user.nickname
    end
  end

  scenario 'search question', sphinx: true do
    visit search_path

    select 'Question', from: 'search_type'
    fill_in :body_body, with: question.title

    click_on 'Find'

    within '.questions' do
      expect(page).to have_content question.title
    end
  end

  scenario 'search answer', sphinx: true do
    visit search_path

    select 'Answer', from: 'search_type'
    fill_in :body_body, with: answer.body

    click_on 'Find'

    within '.answers' do
      expect(page).to have_content answer.body
    end
  end

  scenario 'search comment', sphinx: true do
    visit search_path

    select 'Comment', from: 'search_type'
    fill_in :body_body, with: comment.body

    click_on 'Find'

    within '.comments' do
      expect(page).to have_content comment.body
    end
  end

  scenario 'search all', sphinx: true do
    visit search_path

    select 'All', from: 'search_type'
    fill_in :body_body, with: 'test'

    click_on 'Find'

    within '.users' do
      expect(page).to have_content user.nickname
    end

    within '.questions' do
      expect(page).to have_content question.title
    end

    within '.answers' do
      expect(page).to have_content answer.body
    end

    within '.comments' do
      expect(page).to have_content comment.body
    end
  end
end