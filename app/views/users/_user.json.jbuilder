json.extract! user, :id, :username, :email, :roles, :locale, :nickname, :first_name, :last_name, :created_at, :updated_at
json.url user_url(user, format: :json)
