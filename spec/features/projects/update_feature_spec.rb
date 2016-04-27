require 'rails_helper'

feature 'Create project', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  # REVIEW: Someties specs are fails, sometimes no
  # Failure/Error: raise ActionController::RoutingError, "No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}"
  #
  #    ActionController::RoutingError:
  #      No route matches [PATCH] "/projects"
  skip feature 'User can update project' do
    context 'With correct data' do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        visit "/#/projects/#{@project.uuid}/edit"
        expect(page).to have_selector('.projects__edit__form')
        within '.projects__edit__form' do
          fill_in "Title", with: "New title"
          click_on "Update"
        end
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Project updated")
      end
      scenario 'Should redirect to project' do
        expect(page).to have_selector('.projects__project')
      end
    end
    context 'With incorrect data' do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        visit "/#/projects/#{@project.uuid}/edit"
        expect(page).to have_selector('.projects__edit__form')
        within '.projects__edit__form' do
          fill_in "Title", with: ""
          click_on "Update"
        end
      end
      scenario 'Should not display success notification' do
        expect(page).not_to have_content("Project created")
      end
      scenario 'Should redirect to new project' do
        expect(page).to_not have_selector('.projects__project')
      end
    end
  end
end
