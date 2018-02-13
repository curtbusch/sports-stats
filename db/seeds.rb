# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'net/http'
require 'net/https'
require 'openssl'
require 'json'

Coach.destroy_all
Player.destroy_all
Team.destroy_all
League.destroy_all

# Grab NBA data
nba_league = League.create(name: 'NBA',
                           fullname: 'National Basketball Association')

NBA_BASE_URL = 'http://data.nba.net/prod/v1/2017/'
# Add NBA teams
nba_team_url = NBA_BASE_URL + 'teams.json'
nba_team_uri = URI(nba_team_url)
nba_team_response = Net::HTTP.get(nba_team_uri)
nba_team_data = JSON.parse(nba_team_response)

nba_teams = nba_team_data['league']['standard']

nba_teams.each do |team|
  if team['isNBAFranchise']
    new_team = Team.create(id: team['teamId'],
                           team_name: team['fullName'],
                           city: team['city'],
                           conference: team['confName'],
                           division: team['divName'],
                           league_id: nba_league.id)
  end
end

# Add NBA players
nba_player_url = NBA_BASE_URL + 'players.json'
nba_player_uri = URI(nba_player_url)
nba_player_response = Net::HTTP.get(nba_player_uri)
nba_player_data = JSON.parse(nba_player_response)

nba_players = nba_player_data['league']['standard']

nba_players.each do |player|
  if Team.where(id: player['teamId']).exists?
    new_player = Player.create(id: player['personId'],
                               name: player['firstName'] + ' ' + player['lastName'],
                               teamId: player['teamId'],
                               jersey_number: player['jersey'],
                               position: player['pos'])
  end
end

# Add NBA coaches
nba_coach_url = NBA_BASE_URL + 'coaches.json'
nba_coach_uri = URI(nba_coach_url)
nba_coach_response = Net::HTTP.get(nba_coach_uri)
nba_coach_data = JSON.parse(nba_coach_response)

nba_coaches = nba_coach_data['league']['standard']

nba_coaches.each do |coach|
  if Team.where(id: coach['teamId']).exists?
    new_coach = Coach.create(id: coach['personId'],
                             name: coach['firstName'] + ' ' + coach['lastName'],
                             teamId: coach['teamId'],
                             college: coach['college'])
  end
end

# Grab NHL data
nhl_league = League.create(name: 'NHL',
                           fullname: 'National Hockey League')

nhl_base_url = 'https://statsapi.web.nhl.com/api/v1/'

nhl_team_url = nhl_base_url + 'teams'
nhl_team_uri = URI(nhl_team_url)
nhl_team_response = Net::HTTP.get(nhl_team_uri)
nhl_team_data = JSON.parse(nhl_team_response)

nhl_teams = nhl_team_data['teams']

nhl_teams.each do |team|
  new_team = Team.create(id: team['id'],
                         team_name: team['name'],
                         city: team['locationName'],
                         conference: team['conference']['name'],
                         division: team['division']['name'],
                         league_id: nhl_league.id)

  # Get players
  nhl_players_url = nhl_team_url + "/#{team['id']}/roster"
  nhl_players_uri= URI(nhl_players_url)
  nhl_players_response = Net::HTTP.get(nhl_players_uri)
  nhl_players_data = JSON.parse(nhl_players_response)

  nhl_players = nhl_players_data['roster']

  nhl_players.each do |player|
    new_player = Player.create(id: player['person']['id'],
                               name: player['person']['fullName'],
                               teamId: team['id'],
                               jersey_number: player['jerseyNumber'],
                               position: player['position']['code'])
  end
end

# Grab NFL data
nfl_league = League.create(name: 'NFL',
                           fullname: 'National Football League')

nfl_team_player_url = 'https://api.mysportsfeeds.com/v1.2/pull/nfl/2017-regular/roster_players.json?fordate=20171112'

# Get username and password for api
username = 'username'
password = 'password'

nfl_team_player_uri= URI(nfl_team_player_url)

Net::HTTP.start(nfl_team_player_uri.host, nfl_team_player_uri.port,
                :use_ssl => nfl_team_player_uri.scheme == 'https',
                :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

  request = Net::HTTP::Get.new nfl_team_player_uri.request_uri
  request.basic_auth username, password

  response = http.request request

  nfl_teams_players = JSON.parse(response.body)
  nfl_teams_players = nfl_teams_players['rosterplayers']['playerentry']

  nfl_teams_players.each do |player_team|
    team = player_team['team']
    if !Team.where(id: team['ID'].to_i).exists?
      new_team = Team.create(id: team['ID'].to_i,
                             team_name: team['Name'],
                             city: team['City'],
                             league_id: nfl_league.id)

    end

    player = player_team['player']
    new_player = Player.create(name: player['FirstName'] + ' ' + player['LastName'],
                               teamId: team['ID'].to_i,
                               jersey_number: player['JerseyNumber'].to_i,
                               position: player['Position'])
  end
end

puts League.inspect
puts Team.inspect
puts Player.inspect
puts Coach.inspect