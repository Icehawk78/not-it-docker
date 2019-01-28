json.array!(@player_groups) do |player_group|
  json.extract! player_group, :id, :group_id, :player_id, :bank
  json.url player_group_url(player_group, format: :json)
end
