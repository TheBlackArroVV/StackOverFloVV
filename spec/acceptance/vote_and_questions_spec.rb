require_relative 'acceptance_helper'

feature 'vote for question' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }

  scenario 'all users can see number of votes for question' do
    visit question_path(question)

    expect(page).to have_content 'Question votes'
  end

  scenario 'unloged user try to vote for question' do
    visit question_path(question)

    expect(page).to_not have_content 'vote for question'
  end

  scenario 'loged user try to vote for question' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for question'

    expect(page).to have_content 'vote for question'
    expect(page).to have_content '1'
  end

  scenario 'author try to vote for question' do
    user_authentication(user)
    visit question_path(question)

    expect(page).to_not have_content 'vote for question'
    expect(page).to have_content '0'
  end

  scenario 'unloged user try to vote against question' do
    visit question_path(question)

    expect(page).to_not have_content 'vote against question'
  end

  scenario 'loged user try to vote against question' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote against question'

    expect(page).to have_content 'vote against question'
    expect(page).to have_content '-1'
  end

  scenario 'author try to vote against question' do
    user_authentication(user)
    visit question_path(question)

    expect(page).to_not have_content 'vote against question'
    expect(page).to have_content '0'
  end

  scenario 'user try to delete her vote and vote against again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for question'
    click_on 'delete my vote'
    click_on 'vote against question'

    expect(page).to have_content '-1'
  end

  scenario 'user try to delete her vote and vote for again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for question'
    click_on 'delete my vote'
    click_on 'vote for question'

    expect(page).to have_content '1'
  end

  scenario 'user try to delete her vote and vote for again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote against question'
    click_on 'delete my vote'
    click_on 'vote against question'


    expect(page).to have_content '-1'
  end

  scenario 'user try to delete her vote and vote for again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for question'
    click_on 'delete my vote'
    click_on 'vote for question'

    expect(page).to have_content '1'
  end
end