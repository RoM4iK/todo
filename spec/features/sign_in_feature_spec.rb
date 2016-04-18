require 'rails_helper'

feature 'Sign in', type: :feature, js: true do
  let(:notification_text) { "Successfully signed in" }
  let(:password) { "12345678" }
  before do
    @user = FactoryGirl.create(:user, password: password)
  end
  feature 'User fills sign in form' do
    context 'With correct data' do
      before do
        visit '/#/sign_in'
        expect(page).to have_selector('.sign_in__form')
        within '.sign_in__form' do
          fill_in "Email", with: @user.email
          fill_in "Password", with: password
          click_on "Sign in"
        end
      end
      scenario 'Should display notification' do
        expect(page).to have_content(notification_text)
      end
    end
    context 'With inccorrect data' do
      before do
        visit '/#/sign_in'
        expect(page).to have_selector('.sign_in__form')
        within '.sign_in__form' do
          fill_in "Email", with: @user.email
          fill_in "Password", with: password
          click_on "Sign in"
        end
      end
      scenario 'Should display notification' do
        expect(page).not_to have_content(notification_text)
      end
    end
  end
end
