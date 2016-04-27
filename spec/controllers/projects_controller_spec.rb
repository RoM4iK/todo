require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #index' do
    context 'when user can have projects' do
      before do
        setup_ability
        @ability.can :read, Project
        get :index, format: :json
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
      it { expect(controller).to render_template(:index) }
    end
    context 'when user cannot have projects' do
      before do
        setup_ability
        @ability.cannot :read, Project
        get :index, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
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
      it_behaves_like "not authorized action"
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
    context 'when user can create project' do
      before do
        setup_ability
        @ability.can :create, Project
      end
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
      context "when project already created" do
        before do
          @project = FactoryGirl.create(:project)
          expect(Project.count).to eq(1)
          post :create, project: @project.attributes, format: :json
        end
        it 'should not create new project' do
          expect(Project.count).to eq(1)
        end
        it 'should have 409 http status' do
          expect(response).to have_http_status(409)
        end
        it 'should return errors list' do
          expect(JSON.parse(response.body)["errors"]).to eq(["Uuid has already been taken"])
        end
      end
    end
    context 'when user cannot create project' do
      before do
        setup_ability
        @ability.cannot :create, Project
        @project = FactoryGirl.build(:project)
        post :create, project: @project.attributes, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
  describe 'PATCH #update' do
    context 'when user can update project' do
      before do
        setup_ability
        @project = FactoryGirl.create(:project)
        @ability.can :update, Project
      end
      context "with valid project" do
        before do
          @project.title = "Ninja turtles"
          patch :update, id: @project.uuid, project: @project.attributes, format: :json
        end
        it 'should update project' do
          expect(Project.find(@project.uuid).title).to eq(@project.title)
        end
        it 'should have 200 http status' do
          expect(response).to have_http_status(200)
        end
        it 'should return updated project' do
          expect(response).to render_template(:show)
        end
      end
      context "with invalid project" do
        before do
          @project.title = ""
          patch :update, id: @project.uuid, project: @project.attributes, format: :json
        end
        it 'should not update project' do
          expect(Project.find(@project.uuid).title).not_to eq(@project.title)
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
    context 'when user cannot update project' do
      before do
        setup_ability
        @project = FactoryGirl.create(:project)
        @ability.cannot :update, Project
        patch :update, id: @project.uuid, project: @project.attributes, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
  describe 'DELETE #destroy' do
    context 'when user can delete project' do
      before do
        setup_ability
        @project = FactoryGirl.create(:project)
        expect(Project.count).to eq(1)
        @ability.can :destroy, Project
        delete :destroy, id: @project.uuid, format: :json
      end
      it 'should delete project' do
        expect(Project.count).to eq(0)
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when user cannot delete project' do
      before do
        setup_ability
        @project = FactoryGirl.create(:project)
        @ability.cannot :destroy, Project
        delete :destroy, id: @project.uuid, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
end
