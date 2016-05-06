class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    hande_exception(exception, 403)
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    hande_exception(exception, 404)
  end

  protected
  #REVIEW: is this place for this methods ?
  def create_resource(resource)
    if resource.save
      render :show, status: 201, location: dynamic_resource_path(resource)
    else
      if resource.errors[:uuid] == ["has already been taken"]
        render json: {errors: resource.errors.full_messages}, status: 409
      else
        render json: {errors: resource.errors.full_messages}, status: 403
      end
    end
  end

  def destroy_resource(resource)
    if resource.destroy
      render json: ""
    else
      render json: {errors: resource.errors.full_messages}, status: 403
    end
  end

  def update_resource(resource)
    if resource.update dynamic_resource_params(resource)
      render :show, status: 200
    else
      render json: {errors: resource.errors.full_messages}, status: 403
    end
  end

  def dynamic_resource_path(resource)
    send("#{resource.class.to_s.downcase}_path", resource)
  end

  def dynamic_resource_params(resource)
    send("#{resource.class.to_s.downcase}_params")
  end

  private

  def hande_exception(exception, status)
    respond_to do |format|
      format.json do
        render json: { errors: [exception.message] }, status: status
      end
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end
end
