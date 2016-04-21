require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #show' do
    context 'when user can read project' do
      before do
        setup_ability
        @project = FactoryGirl.create(:project)
        @ability.can :read, Project
        get :show, id: @project, format: :json
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
      it 'should assign project' do
        expect(assigns(:project).uuid).to eq(@project.uuid)
      end
      it 'should return project' do
        expect(response).to render_template(:show)
      end
    end
    context 'when user cannot read project' do
      before do
        setup_ability
        @project = FactoryGirl.create(:project)
        @ability.cannot :read, Project
        get :show, id: @project, format: :json
      end
      it 'should have 403 http status' do
        expect(response).to have_http_status(403)
      end
      it 'should return error message' do
        expect(JSON.parse(response.body)).to eq("errors" => ["You are not authorized to access this page."])
      end
    end
    context 'when project not found' do
      before do
        setup_ability
        @ability.can :read, Project
        get :show, id: "undefined", format: :json
      end
      it 'should have 404 http status' do
        expect(response).to have_http_status(404)
      end
      it 'should return error message' do
        expect(JSON.parse(response.body)).to eq("errors" => ["Couldn't find Project with 'uuid'=undefined"])
      end
    end
  end
  describe 'POST #create' do
    context "with valid project" do
      before do
        @project = FactoryGirl.build(:project)
        post :create, project: @project.attributes, format: :json
      end
      it 'should create new project' do
        expect(Project.last.uuid).to eq(@project.uuid)
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
        # REVIEW: this expectation should be refactored, or no?
        expect(Project.count).to eq(0)
        post :create, project: @project.attributes, format: :json
      end
      it 'should not create new project' do
        expect(Project.count).to eq(0)
      end
      it 'should have 403 http status' do
        expect(response).to have_http_status(403)
      end
      it 'should return errors list' do
        @project.validate
        expect(JSON.parse(response.body)["errors"]).to eq(@project.errors.full_messages)
      end
    end
  end
end
