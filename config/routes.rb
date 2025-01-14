Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :conversations, only: [:index, :show] do
    get :messages, on: :member
  end

  resources :messages, only: [:create]
  
end
