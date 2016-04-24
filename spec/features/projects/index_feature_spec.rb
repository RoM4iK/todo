require 'rails_helper'

feature 'Show projects list', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can look at project' do
    context 'when user have projects' do
      before do
        @projects = FactoryGirl.create_list(:project, 5, user_id: @user.id)
        visit "/#/projects/"
      end
      scenario 'Should display project titles' do
        expect(page).to have_content(@projects[0].title)
      end
    end
    context "when user have no projects" do
      before do
        @project = FactoryGirl.build(:project)
        visit "/#/projects/"
      end
      scenario 'Should display "no projects" message' do
        expect(page).to have_content("You have no projects")
      end
    end
  end
end
