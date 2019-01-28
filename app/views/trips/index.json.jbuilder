json.array!(@trips) do |trip|
  json.extract! trip, :id, :group_id, :description
  json.url trip_url(trip, format: :json)
end
