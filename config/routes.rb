Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "inbox#show"
    get "inbox", to: "inbox#show"

    resources :playables, only: :create
  end

  resources :lists, only: :show do
    resources :playables, only: :show

    member do
      authenticate :user do
        patch "active_playable"
        patch "toggle_repeat"
        patch "toggle_shuffle"
      end
    end
  end
end
