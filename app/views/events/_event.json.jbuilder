json.extract! event, :id, :name, :start, :capacity, :created_at, :updated_at
json.url event_url(event, format: :json)
