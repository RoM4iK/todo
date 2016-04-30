json.array!(@comments) do |comment|
  json.partial! 'comments/show', comment: comment
  json.url comment_url(comment, format: :json)
end
