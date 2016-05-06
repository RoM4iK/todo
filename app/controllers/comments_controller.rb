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
    if @comment.save
      render :show, status: 201, location: comment_path(@comment)
    else
      if @comment.errors[:uuid] == ["has already been taken"]
        render json: {errors: @comment.errors.full_messages}, status: 409
      else
        render json: {errors: @comment.errors.full_messages}, status: 403
      end
    end
  end

  def update
    if @comment.update comment_params
      render :show, status: 200, location: comment_path(@comment)
    else
      render json: {errors: @comment.errors.full_messages}, status: 403
    end
  end

  def destroy
    if @comment.destroy
      render json: ""
    else
      render json: {errors: @comment.errors.full_messages}, status: 403
    end
  end

  def move
    @comment = Task.find(params[:comment_id])
    authorize! :move, @comment
    if @comment.insert_at params.require('position')
      render json: ""
    else
      render json: {errors: @comment.errors.full_messages}, status: 403
    end
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

    # return data to be used as the attachment file (paperclip)
    data
  end
  def comment_params
    params.require('comment').permit('uuid', 'text', 'user_id')
  end
end
