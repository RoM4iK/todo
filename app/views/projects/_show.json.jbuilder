json.extract! project, :uuid, :title, :created_at, :updated_at
json.tasks(project.tasks) do |task|
  json.partial! 'tasks/show', task: task
end
