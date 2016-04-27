class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def create
    if @project.save
      render :show, status: 201, location: project_path(@project)
    else
      if @project.errors[:uuid] == ["has already been taken"]
        render json: {errors: @project.errors.full_messages}, status: 409
      else
        render json: {errors: @project.errors.full_messages}, status: 403
      end
    end
  end

  def update
    if @project.update project_params
      render :show, status: 200, location: project_path(@project)
    else
      render json: {errors: @project.errors.full_messages}, status: 403
    end
  end

  def destroy
    if @project.destroy
      render json: ""
    else
      render json: {errors: @project.errors.full_messages}, status: 403
    end
  end

  private

  def project_params
    params.require('project').permit('title', 'uuid')
  end
end
