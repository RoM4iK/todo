json.extract! task, :uuid, :title, :completed, :comments, :project_uuid, :created_at, :updated_at
json.comments task.comments, partial: 'comments/show', as: :comment
json.deadline_at task.deadline_at && task.deadline_at.strftime('%F')
