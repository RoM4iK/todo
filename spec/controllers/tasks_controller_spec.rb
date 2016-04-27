require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #show' do
    context 'when user can read task' do
      before do
        setup_ability
        @task = FactoryGirl.create(:task)
        @ability.can :read, Task
        get :show, id: @task, format: :json
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
      it 'should assign task' do
        expect(assigns(:task).uuid).to eq(@task.uuid)
      end
      it 'should return task' do
        expect(response).to render_template(:show)
      end
    end
    context 'when user cannot read task' do
      before do
        setup_ability
        @task = FactoryGirl.create(:task)
        @ability.cannot :read, Task
        get :show, id: @task, format: :json
      end
      it_behaves_like "not authorized action"
    end
    context 'when task not found' do
      before do
        setup_ability
        @ability.can :read, Task
        get :show, id: "undefined", format: :json
      end
      it 'should have 404 http status' do
        expect(response).to have_http_status(404)
      end
      it 'should return error message' do
        expect(JSON.parse(response.body)).to eq("errors" => ["Couldn't find Task with 'uuid'=undefined"])
      end
    end
  end
  describe 'POST #create' do
    context 'when user can create task' do
      before do
        setup_ability
        @ability.can :create, Task
      end
      context "with valid task" do
        before do
          @task = FactoryGirl.build(:task)
          post :create, :project_id => @task.project, :task => @task.attributes, :format => :json
        end
        it 'should create new task' do
          expect(Task.last.uuid).to eq(@task.uuid)
        end
        it 'should have 201 http status' do
          expect(response).to have_http_status(201)
        end
        it 'should have location header' do
          expect(response.headers).to include("Location")
        end
        it 'should return created task' do
          expect(response).to render_template(:show)
        end
      end
      context "with invalid task" do
        before do
          @project = FactoryGirl.create(:project)
          @task = Task.new
          # REVIEW: this expectation should be refactored, or no?
          expect(Task.count).to eq(0)
          post :create, :project_id => @project, :task => @task.attributes, :format => :json
        end
        it 'should not create new task' do
          expect(Task.count).to eq(0)
        end
        it 'should have 403 http status' do
          expect(response).to have_http_status(403)
        end
        it 'should return errors list' do
          @task.validate
          expect(JSON.parse(response.body)["errors"]).to eq(@task.errors.full_messages)
        end
      end
      context "when task already created" do
        before do
          @task = FactoryGirl.create(:task)
          expect(Task.count).to eq(1)
          post :create, :project_id => @task.project, :task => @task.attributes, :format => :json
        end
        it 'should not create new task' do
          expect(Task.count).to eq(1)
        end
        it 'should have 409 http status' do
          expect(response).to have_http_status(409)
        end
        it 'should return errors list' do
          expect(JSON.parse(response.body)["errors"]).to eq(["Uuid has already been taken"])
        end
      end
    end
    context 'when user cannot create task' do
      before do
        setup_ability
        @ability.cannot :create, Task
        @task = FactoryGirl.build(:task)
        post :create, :project_id => @task.project, :task => @task.attributes, :format => :json
      end
      it_behaves_like "not authorized action"
    end
  end
  describe 'PATCH #update' do
    context 'when user can update task' do
      before do
        setup_ability
        @task = FactoryGirl.create(:task)
        @ability.can :update, Task
      end
      context "with valid task" do
        before do
          @task.title = "Ninja turtles"
          patch :update, id: @task.uuid, task: @task.attributes, format: :json
        end
        it 'should update task' do
          expect(Task.find(@task.uuid).title).to eq(@task.title)
        end
        it 'should have 200 http status' do
          expect(response).to have_http_status(200)
        end
        it 'should return updated task' do
          expect(response).to render_template(:show)
        end
      end
      context "with invalid task" do
        before do
          @task.title = ""
          patch :update, id: @task.uuid, task: @task.attributes, format: :json
        end
        it 'should not update task' do
          expect(Task.find(@task.uuid).title).not_to eq(@task.title)
        end
        it 'should have 403 http status' do
          expect(response).to have_http_status(403)
        end
        it 'should return errors list' do
          @task.validate
          expect(JSON.parse(response.body)["errors"]).to eq(@task.errors.full_messages)
        end
      end
    end
    context 'when user cannot update task' do
      before do
        setup_ability
        @task = FactoryGirl.create(:task)
        @ability.cannot :update, Task
        patch :update, id: @task.uuid, task: @task.attributes, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
  describe 'DELETE #destroy' do
    context 'when user can delete task' do
      before do
        setup_ability
        @task = FactoryGirl.create(:task)
        expect(Task.count).to eq(1)
        @ability.can :destroy, Task
        delete :destroy, id: @task.uuid, format: :json
      end
      it 'should delete task' do
        expect(Task.count).to eq(0)
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when user cannot delete task' do
      before do
        setup_ability
        @task = FactoryGirl.create(:task)
        expect(Task.count).to eq(1)
        @ability.cannot :destroy, Task
        delete :destroy, id: @task.uuid, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
end
