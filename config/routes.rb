Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :business_assets
  get '/transactions/:id/compare', to: 'transactions#compare', as: 'compare'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
