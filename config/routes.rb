Rails.application.routes.draw do
  get 'player/index'

  get 'player/show'

  get 'teams/index'

  get 'teams/show'

  get 'leagues', to: 'leagues#index', as: 'leagues'
  get 'leagues/:id', to: 'leagues#show', as: 'league', id: /\d+/

  get 'teams/:id', to: 'teams#show', as: 'team', id: /\d+/
end
