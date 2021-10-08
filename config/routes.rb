Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "inbox#show"
    get "inbox", to: "inbox#show"

    resources :list_entries, only: :create
  end

  resources :lists, only: :show do
    resources :list_entries, only: :show

    member do
      authenticate :user do
        patch "active_list_entry"
        patch "toggle_repeat"
        patch "toggle_shuffle"
      end
    end
  end
end
