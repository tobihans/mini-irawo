Rails.application.routes.draw do
  scope "auth" do
    resource :session
    resources :passwords, param: :token
  end

  resources :resources, only: [ :show ]

  scope "_", as: "admin", admin: true do
    resources :resources, except: [ :index ]
    root "resources#index"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "resources#index"
end
