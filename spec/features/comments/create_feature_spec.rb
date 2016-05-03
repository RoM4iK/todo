require 'rails_helper'

feature 'Create comments', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can create comment' do
    context 'With correct data' do
      before do
        @project = FactoryGirl.create(:project, user: @user)
        @task = FactoryGirl.create(:task, project: @project)
        @comment = FactoryGirl.build(:comment)
        visit "/#/projects/#{@project.uuid}"
        find('.tasks__task__header').click
        expect(page).to have_content('Comments')
        within '.comments__create_form' do
          fill_in "text", with: @comment.text
          find('button[type="submit"]').trigger('click')
        end
      end
      scenario 'Should display new comment' do
        expect(page).to have_content(@comment.text)
      end
    end
    context 'With incorrect data' do
      before do
        @project = FactoryGirl.create(:project, user: @user)
        @task = FactoryGirl.create(:task, project: @project)
        @comment = Comment.new
        visit "/#/projects/#{@project.uuid}"
        find('.tasks__task__header').click
        expect(page).to have_content('Comments')
        within '.comments__create_form' do
          fill_in "text", with: @comment.text
          find('button[type="submit"]').trigger('click')
        end
      end
      scenario 'Should not display new comment' do
        expect(page).to have_content(@comment.text)
      end
    end
  end
end
