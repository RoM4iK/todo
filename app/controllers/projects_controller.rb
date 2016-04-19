class ProjectsController < ApplicationController
  load_and_authorize_resource
  def index
  end

  def show
  end

  def create
  end

  def update
  end

  def delete
  end

  private

  def project_params
    params.require('project').permit('title')
  end
end
