Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    member do
      put "like", to: "posts#upvote"
    end
    collection do
      get 'search'
    end
    resources :comments do
      member do
        put "like", to: "comments#upvote"
      end
    end 
  end

  root 'posts#index'
end
