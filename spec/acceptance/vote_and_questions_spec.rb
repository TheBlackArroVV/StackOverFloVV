require_relative 'acceptance_helper'

feature 'vote for question' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }

  before do
    user.confirm
    new_user.confirm
  end

  scenario 'all users can see number of votes for question', js: true do
    visit question_path(question)

    within '.votes' do
      expect(page).to have_content '0'
    end
  end

  scenario 'unloged user try to vote for question', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Vote for question'
  end

  scenario 'loged user try to vote for question', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote for question'

    expect(page).to have_content '1'
  end

  scenario 'author try to vote for question', js: true do
    user_authentication(user)
    visit question_path(question)

    expect(page).to_not have_content 'Vote for question'
    expect(page).to have_content '0'
  end

  scenario 'unloged user try to vote against question', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Vote against question'
  end

  scenario 'loged user try to vote against question', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote against question'

    expect(page).to have_content '-1'
  end

  scenario 'author try to vote against question', js: true do
    user_authentication(user)
    visit question_path(question)

    expect(page).to_not have_content 'Vote against question'
    expect(page).to have_content '0'
  end

  scenario 'user try to delete her vote and vote for again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote for question'
    click_on 'Delete my vote'
    click_on 'Vote for question'

    expect(page).to have_content '1'
  end

  scenario 'user try to delete her vote and vote for again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote against question'
    click_on 'Delete my vote'
    click_on 'Vote against question'


    expect(page).to have_content '-1'
  end

  scenario 'user try to delete her vote and vote for again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote for question'
    click_on 'Delete my vote'
    click_on 'Vote for question'

    expect(page).to have_content '1'
  end
end