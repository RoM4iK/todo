class TasksController < ApplicationController
  load_resource :project
  load_and_authorize_resource through: :project, shallow: true

  def index
  end

  def show
  end

  def create
    if @task.save
      render :show, status: 201, location: task_path(@task)
    else
      if @task.errors[:uuid] == ["has already been taken"]
        render json: {errors: @task.errors.full_messages}, status: 409
      else
        render json: {errors: @task.errors.full_messages}, status: 403
      end
    end
  end

  def update
    if @task.update task_params
      render :show, status: 200, location: task_path(@task)
    else
      render json: {errors: @task.errors.full_messages}, status: 403
    end
  end

  def destroy
    if @task.destroy
      render json: ""
    else
      render json: {errors: @task.errors.full_messages}, status: 403
    end
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
