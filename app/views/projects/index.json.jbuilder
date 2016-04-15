json.array!(@projects) do |project|
  json.extract! project, :id, :index, :show, :create, :update, :delete
  json.url project_url(project, format: :json)
end
