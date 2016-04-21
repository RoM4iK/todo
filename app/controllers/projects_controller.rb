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

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.json do
        render json: { errors: [exception.message] }, status: 404
      end
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end

  private

  def project_params
    params.require('project').permit('title', 'uuid')
  end
end
