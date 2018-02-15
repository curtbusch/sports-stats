Rails.application.routes.draw do
  get 'leagues', to: 'leagues#index', as: 'leagues'
  get 'leagues/:id', to: 'leagues#show', as: 'league', id: /\d+/
end
