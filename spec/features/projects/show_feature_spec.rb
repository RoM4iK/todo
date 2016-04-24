require 'rails_helper'

feature 'Show project', type: :feature, js: true do
  before do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  feature 'User can look at project' do
    context 'when project exist' do
      before do
        @project = FactoryGirl.create(:project, user_id: @user.id)
        visit "/#/projects/#{@project.uuid}"
      end
      scenario 'Should display project title' do
        expect(page).to have_content(@project.title)
      end
    end
    context "when project doesn't exist" do
      before do
        @project = FactoryGirl.build(:project)
        visit "/#/projects/#{@project.uuid}"
      end
      scenario 'Should display 404 title' do
        expect(page).to have_content("404")
      end
    end
  end
end
