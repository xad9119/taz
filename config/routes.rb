Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :business_assets do
    collection do
      get 'search/', :action => 'search', :as => 'search'
    end
  end

  get 'dashboard', to: "business_assets#dashboard", as: :dashboard
  get '/transactions/:id/compare', to: 'transactions#compare', as: 'compare'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
