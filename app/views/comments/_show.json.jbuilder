json.extract! comment, :uuid, :text, :task_uuid, :user, :created_at, :updated_at
json.image comment.image.present? && comment.image.url
json.thumbnail comment.image.present? && comment.image.url(:thumb)
