json.extract! admin_player, :id, :name, :birthdate, :position, :status, :joined_on, :left_on, :team_id, :created_at, :updated_at
json.url admin_player_url(admin_player, format: :json)
