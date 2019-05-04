Rails.application.routes.draw do
  resources :surveys do
    resources :options
  end
end
