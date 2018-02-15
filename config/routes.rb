Rails.application.routes.draw do
  get 'about/index'

  get 'about/show'

  get 'coaches/index'

  get 'coaches/show'

  get 'player/index'

  get 'player/show'

  get 'teams/index'

  get 'teams/show'

  get 'leagues', to: 'leagues#index', as: 'leagues'
  get 'leagues/:id', to: 'leagues#show', as: 'league', id: /\d+/

  get 'teams/:id', to: 'teams#show', as: 'team', id: /\d+/

  get 'players/:id', to: 'player#show', as: 'player', id: /\d+/

  get 'coaches/:id', to: 'coaches#show', as: 'coach', id: /\d+/

  get 'about', to: 'about#index', as: 'about'
end
