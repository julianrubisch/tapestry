Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "inbox#show"
    get "inbox", to: "inbox#show"

    resources :list_entries
  end

  resources :lists
end
