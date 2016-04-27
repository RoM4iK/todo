class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json do
        render json: { errors: [exception.message] }, status: 403
      end
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.json do
        render json: { errors: [exception.message] }, status: 404
      end
      format.html { redirect_to root_url, :alert => exception.message }
    end
  end
end
