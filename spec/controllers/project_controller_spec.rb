require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'POST #create' do
    context "with valid project" do
      before do
        @project = FactoryGirl.build(:project)
        post :create, project: @project.attributes, :format => :json
      end
      it 'should create new project' do
        expect(Project.last.id).to eq(@project.id)
      end
      it 'should have 201 http status' do
        expect(response).to have_http_status(201)
      end
      it 'should have location header' do
        expect(response.headers).to include("Location")
      end
      it 'should return created project' do
        expect(response).to render_template(:show)
      end
    end
    context "with invalid project" do
      before do
        @project = Project.new
      end
      it 'should not create new project' do
        expect{ post :create, project: @project.attributes }.not_to change(Project, :count)
      end
    end
  end
end
