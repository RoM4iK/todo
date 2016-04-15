json.array!(@user_registrations) do |user_registration|
  json.extract! user_registration, :id
  json.url user_registration_url(user_registration, format: :json)
end
