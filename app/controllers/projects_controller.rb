class ProjectsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def create
    create_resource(@project)
  end

  def update
    update_resource(@project)
  end

  def destroy
    destroy_resource(@project)
  end

  private

  def project_params
    params.require('project').permit('title', 'uuid')
  end
end
