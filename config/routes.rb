Rails.application.routes.draw do
  get 'teams/index'

  get 'teams/show'

  get 'leagues', to: 'leagues#index', as: 'leagues'
  get 'leagues/:id', to: 'leagues#show', as: 'league', id: /\d+/
end
