require 'rails_helper'

feature 'Sign up', type: :feature, js: true do
  let(:notification_text) { "Successfully registered" }
  feature 'User fills sign up form' do
    context 'With correct data' do
      before do
        @email = "test@mail.ru"
        @password = "12345678"
        visit '/#/sign_up'
        expect(page).to have_selector('.sign_up__form')
        within '.sign_up__form' do
          fill_in "Email", with: @email
          fill_in "Password", with: @password
          click_on "Sign up"
        end
      end
      scenario 'Should display notification' do
        expect(page).to have_content(notification_text)
      end
    end
    context 'With inccorrect data' do
      before do
        @email = "test@mail.ru"
        @password = "1"
        visit '/#/sign_up'
        expect(page).to have_selector('.sign_up__form')
        within '.sign_up__form' do
          fill_in "Email", with: @email
          fill_in "Password", with: @password
          click_on "Sign up"
        end
      end
      scenario 'Should display notification' do
        expect(page).not_to have_content(notification_text)
      end
    end
  end
end
