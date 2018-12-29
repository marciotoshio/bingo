Rails.application.routes.draw do
  resource :games do
    get ':slug', to: 'games#show', as: 'show'
    get ':slug/draw', to: 'games#draw', as: 'draw'
  end

  root to: 'home#index'
end
