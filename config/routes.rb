Rails.application.routes.draw do
  scope "auth" do
    resource :session
    resources :passwords, param: :token
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "resources#index"
end
