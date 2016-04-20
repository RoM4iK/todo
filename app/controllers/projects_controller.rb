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
      render json: {errors: @project.errors.full_messages}, status: 403
    end
  end

  def update
  end

  def delete
  end

  private

  def project_params
    params.require('project').permit('title', 'uuid')
  end
end
