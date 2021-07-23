Rails.application.routes.draw do
  get 'tracks/show'
  devise_for :users

  authenticated :user do
    root "inbox#show"
    get "inbox", to: "inbox#show"

    resources :list_entries, only: :create
  end

  resources :lists, only: :show do
    member do
      authenticate :user do
        patch "active_track"
      end
    end
  end

  resources :tracks, only: :show
end
