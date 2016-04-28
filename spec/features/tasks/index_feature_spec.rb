require 'rails_helper'

feature 'Show tasks list', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can look at tasks' do
    before do
      @project = FactoryGirl.create(:project, user_id: @user.id)
      @task = FactoryGirl.create(:task, project: @project)
      visit "/#/projects/#{@project.uuid}"
    end
    scenario 'Should display task' do
      expect(page).to have_content(@task.title)
    end
  end
end
