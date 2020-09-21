Rails.application.routes.draw do

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  resources :articles do
    collection do
      get "search"
    end
    member do
      patch "release", to: "articles#release"
      patch "unrelease", to: "articles#unrelease"
    end
  end

  get "/top", to: "articles#top"

  root "articles#index"

end
