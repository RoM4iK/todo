class TasksController < ApplicationController
  load_resource :project
  load_and_authorize_resource through: :project, shallow: true

  def index
  end

  def show
  end

  def create
    create_resource(@task)
  end

  def update
    update_resource(@task)
  end

  def destroy
    destroy_resource(@task)
  end

  def move
    @task = Task.find(params[:task_id])
    authorize! :move, @task
    if @task.insert_at params.require('position')
      render json: ""
    else
      render json: {errors: @task.errors.full_messages}, status: 403
    end
  end

  private

  def task_params
    params.require('task').permit('title', 'uuid', 'deadline_at', 'completed')
  end
end
