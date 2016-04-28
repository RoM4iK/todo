require 'rails_helper'

feature 'Create task', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can create tasks' do
    context 'With correct data' do
      before do
        @project = FactoryGirl.create(:project, user: @user)
        @task = FactoryGirl.build(:task)
        visit "/#/projects/#{@project.uuid}"
        expect(page).to have_selector('.tasks')
        find('.tasks_create_panel .collapsible-header').click
        within '.projects__create_task__form' do
          fill_in "Title", with: @task.title
          click_on "Create"
        end
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Task created")
      end
      scenario 'Should display new task' do
        expect(page).to have_content(@task.title)
      end
    end
    context 'With incorrect data' do
      before do
        @project = FactoryGirl.create(:project, user: @user)
        @task = Task.new
        visit "/#/projects/#{@project.uuid}"
        expect(page).to have_selector('.tasks')
        find('.tasks_create_panel .collapsible-header').click
        within '.projects__create_task__form' do
          fill_in "Title", with: @task.title
          click_on "Create"
        end
      end
      scenario 'Should not display notification' do
        expect(page).not_to have_content("Task created")
      end
    end
  end
end
