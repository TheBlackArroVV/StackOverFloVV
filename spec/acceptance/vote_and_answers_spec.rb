require_relative 'acceptance_helper'

feature 'vote for answer' do
  given(:user) { create :user }
  given(:new_user) { create :user }
  given(:question) { create :question, user: user }
  given!(:answer) { create :answer, user: user, question: question }

  before do
    user.confirm
    new_user.confirm
  end

  scenario 'all users can see number of votes for answer', js: true do
    visit question_path(question)

    within '.answer_votes_1' do
      expect(page).to have_content '0'
    end
  end

  scenario 'unloged user try to vote for question', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Vote for answer'
  end

  scenario 'loged user try to vote for answer', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote for answer'

    within '.answer_votes_1' do
      expect(page).to have_content '1'
    end
  end

  scenario 'author try to vote for answer', js: true do
    user_authentication(user)
    visit question_path(question)

    within '.answer_votes_1' do
      expect(page).to_not have_content 'Vote for answer'
      expect(page).to have_content '0'
    end
  end

  scenario 'unloged user try to vote against answer', js: true do
    visit question_path(question)

    expect(page).to_not have_content 'Vote against answer'
  end

  scenario 'loged user try to vote against answer', js: true do
    user_authentication(new_user)
    visit question_path(question)
    click_on 'Vote against answer'

    within '.answer_votes_1' do
      expect(page).to have_content '-1'
    end
  end

  scenario 'author try to vote against answer', js: true do
    user_authentication(user)
    visit question_path(question)

    within '.answer_votes_1' do
      expect(page).to_not have_content 'Vote against answer'
      expect(page).to have_content '0'
    end
  end

  scenario 'user try to delete her vote and vote against again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    within '.answers' do
      click_on 'Vote for answer'
      click_on 'Delete my vote'
      click_on 'Vote against answer'
    end

    within '.answer_votes_1' do
      expect(page).to have_content '-1'
    end
  end

  scenario 'user try to delete her vote and vote for again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    within '.answers' do
      click_on 'Vote for answer'
      click_on 'Delete my vote'
      click_on 'Vote for answer'
    end

    within '.answer_votes_1' do
      expect(page).to have_content '1'
    end
  end

  scenario 'user try to delete her vote and vote for again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    within '.answers' do
      click_on 'Vote against answer'
      click_on 'Delete my vote'
      click_on 'Vote against answer'
    end


    within '.answer_votes_1' do
      expect(page).to have_content '-1'
    end
  end

  scenario 'user try to delete her vote and vote for again', js: true do
    user_authentication(new_user)
    visit question_path(question)
    within '.answers' do
      click_on 'Vote for answer'
      click_on 'Delete my vote'
      click_on 'Vote for answer'
    end

    within '.answer_votes_1' do
      expect(page).to have_content '1'
    end
  end
end