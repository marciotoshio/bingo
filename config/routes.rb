# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resource :games do
    get ':slug', to: 'games#show', as: 'show'
    get ':slug/draw', to: 'games#draw', as: 'draw'
    get ':slug/reset', to: 'games#reset', as: 'reset'
    get ':slug/select_number/:number', to: 'games#select_number', as: 'select_number'
    get ':slug/players/show/:id', to: 'players#show', as: 'player'
  end

  root to: 'home#index'
end
