Rails.application.routes.draw do
  resource :games do
    get ':slug', to: 'games#show', as: 'show'
  end

  root to: 'home#index'
end
