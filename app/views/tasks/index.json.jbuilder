json.array!(@tasks) do |task|
  json.partial! 'tasks/show', task: task
  json.url task_url(task, format: :json)
end
