require 'rails_helper'

feature 'Update task', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can update task' do
    context 'With correct data' do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        @task = FactoryGirl.create(:task, project: @project)
        visit "/#/projects/#{@project.uuid}"
        find('.tasks__edit_button').click
        within '.tasks__edit__form' do
          fill_in "Title", with: "New title"
        end
        find('.tasks__save_button').click
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Task updated")
      end
      scenario 'Should update task title' do
        expect(page).to have_content("New title")
      end
    end
  end
end
