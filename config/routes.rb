Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  namespace :api do
    namespace :v1 do
      resource :user, only: [:create]
    end
  end
end
