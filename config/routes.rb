Rails.application.routes.draw do
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
        patch "toggle_repeat"
        patch "toggle_shuffle"
      end
    end
  end

  resources :tracks, only: :show
end
