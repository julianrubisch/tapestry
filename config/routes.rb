Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "inbox#show"
    get "inbox", to: "inbox#show"
  end

  resources :lists
end
