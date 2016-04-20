json.array!(@projects) do |project|
  json.partial! 'projects/show', project: project
  json.url project_url(project, format: :json)
end
