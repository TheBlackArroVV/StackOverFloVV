require 'acceptance/acceptance_helper'

feature 'User and authentication' do
  given!(:user) { create :user }

  scenario 'registred user try to login' do
    user_authentication(user)

    expect(page).to have_content 'Signed in successfully'
  end

  scenario 'unregistred user try to login' do
    visit new_user_session_path

    fill_in :user_email, with: 'wrong@email.com'
    fill_in :user_password, with: 'wrongpassword'

    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end

  scenario 'loged user try log out' do
    user_authentication(user)

    click_on 'log out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'user can register in system' do
    visit new_user_registration_path

    fill_in :user_email, with: 'new_email@email.com'
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password

    within 'form#new_user' do
      click_on 'Sign up'
    end

    expect(page).to have_content 'Welcome! You have signed up successfully'
  end
end
