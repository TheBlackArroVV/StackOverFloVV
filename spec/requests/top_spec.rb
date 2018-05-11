require 'capybara/email/rspec'
require "rails_helper.rb"

feature "omniauth github" do
  describe "access top page" do
    it "can sign in user with GitHub account" do
      visit root_path
      click_link "log in"
      github_auth_hash
      click_link "Sign in with GitHub"
      User.last.confirm
      click_link "Sign in with GitHub"
      expect(page).to have_content("Successfully authenticated from GitHub account.")
    end

    it "can handle authentication error" do
      OmniAuth.config.mock_auth[:github] = :invalid_credentials
      visit root_path
      click_link "log in"
      expect(page).to have_content("Sign in with GitHub")
      click_link "Sign in with GitHub"
      expect(page).to have_content('Could not authenticate you from GitHub because "Invalid credentials".')
    end
  end
end