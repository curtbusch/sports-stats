# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'net/http'
require 'json'

Team.destroy_all

# Grab NBA data
nba_team_url = 'http://data.nba.net/prod/v1/2017/teams.json'
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
                           division: team['divName'])
  end
end

