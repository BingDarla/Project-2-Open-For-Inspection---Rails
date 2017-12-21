json.extract! user, :id, :name,:dob,:email
json.url user_url(user, format: :json)
