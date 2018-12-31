Rails.application.routes.draw do
  resource :games do
    get ':slug', to: 'games#show', as: 'show'
    get ':slug/draw', to: 'games#draw', as: 'draw'
    get ':slug/reset', to: 'games#reset', as: 'reset'
    get ':slug/select_number/:number', to: 'games#select_number', as: 'select_number'
  end

  root to: 'home#index'
end
