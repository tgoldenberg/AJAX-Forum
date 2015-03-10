Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    collection do
      get 'search'
    end
    resources :comments
  end

  root 'posts#index'
end
