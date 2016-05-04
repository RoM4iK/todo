require 'rails_helper'

feature 'Destroy comments', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can destroy comment' do
    context "when user confirms destruction" do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        @task = FactoryGirl.create(:task, project: @project)
        @comment = FactoryGirl.create(:comment, task: @task)
        visit "/#/projects/#{@project.uuid}"
        find('.tasks__task__header').click
        expect(page).to have_selector('.comments__delete_button')
        find('.comments__delete_button').trigger('click')
        accept_confirm
      end
      scenario 'Should display notification' do
        expect(page).to have_content("Comment deleted")
      end
      scenario 'Should remove task from page' do
        expect(page).not_to have_content(@comment.text)
      end
    end
    context "when user has not confirmed destruction" do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        @task = FactoryGirl.create(:task, project: @project)
        @comment = FactoryGirl.create(:comment, task: @task)
        visit "/#/projects/#{@project.uuid}"
        find('.tasks__task__header').click
        expect(page).to have_selector('.comments__delete_button')
        find('.comments__delete_button').trigger('click')
        dismiss_confirm
      end
      scenario 'Should not display notification' do
        expect(page).not_to have_content("Comment deleted")
      end
      scenario 'Should not remove task from page' do
        expect(page).to have_content(@comment.text)
      end
    end
  end
end
