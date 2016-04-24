require 'rails_helper'

feature 'Create project', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can create project' do
    context 'With correct data' do
      before do
        @project = FactoryGirl.build(:project)
        @create_path = '/#/projects/create'
        visit @create_path
        expect(page).to have_selector('.projects__create__form')
        within '.projects__create__form' do
          fill_in "Title", with: @project.title
          click_on "Create"
        end
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Project created")
      end
      scenario 'Should redirect to new project' do
        expect(page).to have_selector('.projects__project')
      end
    end
    context 'With inccorrect data' do
      before do
        @project = FactoryGirl.build(:project)
        @create_path = '/#/projects/create'
        visit @create_path
        expect(page).to have_selector('.projects__create__form')
        within '.projects__create__form' do
          fill_in "Title", with: ""
          click_on "Create"
        end
      end
      scenario 'Should not display success notification' do
        expect(page).not_to have_content("Project created")
      end
      scenario 'Should display error notification' do
        expect(page).not_to have_selector(".ui-notification.error")
      end
      scenario 'Should redirect to new project' do
        expect(page).to_not have_selector('.projects__project')
      end
    end
  end
end
