Rails.application.routes.draw do
  scope "auth" do
    resource :session
    resources :passwords, param: :token
  end

  resources :resources, only: [ :show ]

  scope "_", as: "admin" do
    resources :resources, except: [ :index, :show ]
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "resources#index"
end
