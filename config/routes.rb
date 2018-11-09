Rails.application.routes.draw do
  get 'braintree/new'
  get 'profile/Show'
  get 'reservations/index'
  get 'user/index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
#add clearance to middle piece if stuff fucks up
  get "/sign_in" => "sessions#new", as: "sign_in"
  delete "/sign_out" => "sessions#destroy", as: "sign_out"
  get "/sign_up" => "users#new", as: "sign_up"
  get 'welcome/index'
  post '/listings/:id/verify' => "listings#verify", as: "verify"
  #as: verify = listings#verify
  #name
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :reservations
  resources :listings do
    resources :reservations
  end
  root 'welcome#index'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  post '/reservations/:id/checkout' => 'reservations#checkout', as: "checkout"
  #url part (important part here is the id wildcard)// reservations#checkout controller // checkout is name of path
end

