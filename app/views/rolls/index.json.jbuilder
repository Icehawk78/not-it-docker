json.array!(@rolls) do |roll|
  json.extract! roll, :id, :trip_id, :player_group_id, :modifier, :raw_value
  json.url roll_url(roll, format: :json)
end
