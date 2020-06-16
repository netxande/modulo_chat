json.extract! consumer, :id, :description, :author, :token, :created_at, :updated_at
json.url consumer_url(consumer, format: :json)
