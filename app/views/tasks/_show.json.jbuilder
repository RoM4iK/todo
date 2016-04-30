json.extract! task, :uuid, :title, :completed, :comments, :project_uuid, :created_at, :updated_at
json.deadline_at task.deadline_at && task.deadline_at.strftime('%F')
