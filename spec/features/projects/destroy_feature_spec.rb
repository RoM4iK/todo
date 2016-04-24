require 'rails_helper'

feature 'Destroy project', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can destroy project' do
    context "when user confirms destruction" do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        visit "/#/projects/#{@project.uuid}"
        expect(page).to have_content(@project.title)
        expect(page).to have_selector('.projects__delete_button')
        find('.projects__delete_button').click
        accept_confirm
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Project deleted")
      end
      scenario 'Should redirect to projects index' do
        expect(page).to have_content("You have no projects")
      end
    end
    context "when user has not confirmed destruction" do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        visit "/#/projects/#{@project.uuid}"
        expect(page).to have_content(@project.title)
        expect(page).to have_selector('.projects__delete_button')
        find('.projects__delete_button').click
        dismiss_confirm
      end
      scenario 'Should not display notification' do
        expect(page).not_to have_content("Project deleted")
      end
      scenario 'Should not redirect to projects index' do
        expect(page).not_to have_content("You have no projects")
      end
    end
  end
end
