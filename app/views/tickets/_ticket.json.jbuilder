json.extract! ticket, :id, :user, :category, :event_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
