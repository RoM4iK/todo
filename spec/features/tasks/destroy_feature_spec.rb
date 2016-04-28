require 'rails_helper'

feature 'Destroy task', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can destroy task' do
    context "when user confirms destruction" do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        @task = FactoryGirl.create(:task, project: @project)
        visit "/#/projects/#{@project.uuid}"
        expect(page).to have_selector('.tasks__delete_button')
        find('.tasks__delete_button').click
        accept_confirm
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Task deleted")
      end
      scenario 'Should remove task from page' do
        expect(page).not_to have_content(@task.title)
      end
    end
    context "when user has not confirmed destruction" do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        @task = FactoryGirl.create(:task, project: @project)
        visit "/#/projects/#{@project.uuid}"
        expect(page).to have_selector('.tasks__delete_button')
        find('.tasks__delete_button').click
        dismiss_confirm
      end
      scenario 'Should not display notification' do
        expect(page).not_to have_content("Task deleted")
      end
      scenario 'Should not remove task from page' do
        expect(page).to have_content(@task.title)
      end
    end
  end
end
