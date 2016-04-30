require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'GET #show' do
    context 'when user can read comment' do
      before do
        setup_ability
        @comment = FactoryGirl.create(:comment)
        @ability.can :read, Comment
        get :show, id: @comment, format: :json
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
      it 'should assign comment' do
        expect(assigns(:comment).uuid).to eq(@comment.uuid)
      end
      it 'should return comment' do
        expect(response).to render_template(:show)
      end
    end
    context 'when user cannot read comment' do
      before do
        setup_ability
        @comment = FactoryGirl.create(:comment)
        @ability.cannot :read, Comment
        get :show, id: @comment, format: :json
      end
      it_behaves_like "not authorized action"
    end
    context 'when comment not found' do
      before do
        setup_ability
        @ability.can :read, Comment
        get :show, id: "undefined", format: :json
      end
      it 'should have 404 http status' do
        expect(response).to have_http_status(404)
      end
      it 'should return error message' do
        expect(JSON.parse(response.body)).to eq("errors" => ["Couldn't find Comment with 'uuid'=undefined"])
      end
    end
  end
  describe 'POST #create' do
    context 'when user can create comment' do
      before do
        setup_ability
        @ability.can :create, Comment
        @user = FactoryGirl.create(:user)
        allow(controller).to receive(:current_user) { @user }
      end
      context "with valid comment" do
        before do
          @comment = FactoryGirl.build(:comment)
          post :create, :task_id => @comment.task, :comment => @comment.attributes, :format => :json
        end
        it 'should create new comment' do
          expect(Comment.last.uuid).to eq(@comment.uuid)
        end
        it 'should assign comment user' do
          expect(Comment.find(@comment.uuid).user).to eq(@user)
        end
        it 'should have 201 http status' do
          expect(response).to have_http_status(201)
        end
        it 'should have location header' do
          expect(response.headers).to include("Location")
        end
        it 'should return created comment' do
          expect(response).to render_template(:show)
        end
      end
      context "with invalid comment" do
        before do
          @task = FactoryGirl.create(:task)
          @comment = Comment.new
          # REVIEW: this expectation should be refactored, or no?
          expect(Comment.count).to eq(0)
          post :create, :task_id => @task, :comment => @comment.attributes, :format => :json
        end
        it 'should not create new comment' do
          expect(Comment.count).to eq(0)
        end
        it 'should have 403 http status' do
          expect(response).to have_http_status(403)
        end
        it 'should return errors list' do
          @comment.validate
          expect(JSON.parse(response.body)["errors"]).to eq(@comment.errors.full_messages)
        end
      end
      context "when comment already created" do
        before do
          @comment = FactoryGirl.create(:comment)
          expect(Comment.count).to eq(1)
          post :create, :task_id => @comment.task, :comment => @comment.attributes, :format => :json
        end
        it 'should not create new comment' do
          expect(Comment.count).to eq(1)
        end
        it 'should have 409 http status' do
          expect(response).to have_http_status(409)
        end
        it 'should return errors list' do
          expect(JSON.parse(response.body)["errors"]).to eq(["Uuid has already been taken"])
        end
      end
    end
    context 'when user cannot create comment' do
      before do
        setup_ability
        @ability.cannot :create, Comment
        @comment = FactoryGirl.build(:comment)
        post :create, :task_id => @comment.task, :comment => @comment.attributes, :format => :json
      end
      it_behaves_like "not authorized action"
    end
  end
  describe 'PATCH #update' do
    context 'when user can update comment' do
      before do
        setup_ability
        @comment = FactoryGirl.create(:comment)
        @ability.can :update, Comment
      end
      context "with valid comment" do
        before do
          @comment.text = "Ninja turtles"
          patch :update, id: @comment.uuid, comment: @comment.attributes, format: :json
        end
        it 'should update comment' do
          expect(Comment.find(@comment.uuid).text).to eq(@comment.text)
        end
        it 'should have 200 http status' do
          expect(response).to have_http_status(200)
        end
        it 'should return updated comment' do
          expect(response).to render_template(:show)
        end
      end
      context "with invalid comment" do
        before do
          @comment.text = ""
          patch :update, id: @comment.uuid, comment: @comment.attributes, format: :json
        end
        it 'should not update comment' do
          expect(Comment.find(@comment.uuid).text).not_to eq(@comment.text)
        end
        it 'should have 403 http status' do
          expect(response).to have_http_status(403)
        end
        it 'should return errors list' do
          @comment.validate
          expect(JSON.parse(response.body)["errors"]).to eq(@comment.errors.full_messages)
        end
      end
    end
    context 'when user cannot update comment' do
      before do
        setup_ability
        @comment = FactoryGirl.create(:comment)
        @ability.cannot :update, Comment
        patch :update, id: @comment.uuid, comment: @comment.attributes, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
  describe 'DELETE #destroy' do
    context 'when user can delete task' do
      before do
        setup_ability
        @comment = FactoryGirl.create(:comment)
        expect(Comment.count).to eq(1)
        @ability.can :destroy, Comment
        delete :destroy, id: @comment.uuid, format: :json
      end
      it 'should delete comment' do
        expect(Comment.count).to eq(0)
      end
      it 'should have 200 http status' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when user cannot delete comment' do
      before do
        setup_ability
        @comment = FactoryGirl.create(:comment)
        expect(Comment.count).to eq(1)
        @ability.cannot :destroy, Comment
        delete :destroy, id: @comment.uuid, format: :json
      end
      it_behaves_like "not authorized action"
    end
  end
end
