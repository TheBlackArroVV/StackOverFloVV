require_relative 'acceptance_helper'

feature 'vote for answer' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given(:answer) { create :answer, user: user, question: question }

  scenario 'all users can see number of votes for answer' do
    visit question_path(question)

    expect(page).to have_content 'Answer votes'
  end

  scenario 'unloged user try to vote for question' do
    visit question_path(question)

    expect(page).to_not have_content 'vote for answer'
  end

  scenario 'loged user try to vote for answer' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for answer'

    within '.answers' do
      expect(page).to have_content 'vote for answer'
      expect(page).to have_content '1'
    end
  end

  scenario 'author try to vote for answer' do
    user_authentication(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_content 'vote for answer'
      expect(page).to have_content '0'
    end
  end

  scenario 'unloged user try to vote against answer' do
    visit question_path(question)

    expect(page).to_not have_content 'vote against answer'
  end

  scenario 'loged user try to vote against answer' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote against answer'

    within '.answers' do
      expect(page).to have_content 'vote against answer'
      expect(page).to have_content '-1'
    end
  end

  scenario 'author try to vote against answer' do
    user_authentication(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_content 'vote against answer'
      expect(page).to have_content '0'
    end
  end

  scenario 'user try to delete her vote and vote against again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for answer'
    click_on 'delete my vote'
    click_on 'vote against answer'

    within '.answers' do
      expect(page).to have_content '-1'
    end
  end

  scenario 'user try to delete her vote and vote for again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for answer'
    click_on 'delete my vote'
    click_on 'vote for answer'

    within '.answers' do
      expect(page).to have_content '1'
    end
  end

  scenario 'user try to delete her vote and vote for again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote against answer'
    click_on 'delete my vote'
    click_on 'vote against answer'


    expect(page).to have_content '-1'
  end

  scenario 'user try to delete her vote and vote for again' do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'vote for answer'
    click_on 'delete my vote'
    click_on 'vote for answer'

    expect(page).to have_content '1'
  end
end