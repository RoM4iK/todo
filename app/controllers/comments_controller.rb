class CommentsController < ApplicationController
  load_resource :task
  load_and_authorize_resource through: :task, shallow: true

  def index
  end

  def show
  end

  def create
    @comment.user = current_user
    @comment.image = decode_image
    create_resource(@comment)
  end

  def update
    update_resource(@comment)
  end

  def destroy
    destroy_resource(@comment)
  end

  private

  def decode_image
    return if params[:image].blank?
    decoded_data = Base64.decode64(params["image"]["base64"])
    data = StringIO.new(decoded_data)
    data.class_eval do
      attr_accessor :content_type, :original_filename
    end
    data.content_type = params["image"]["filetype"]
    data.original_filename = params["image"]["filename"]
    data
  end
  def comment_params
    params.require('comment').permit('uuid', 'text', 'user_id')
  end
end
