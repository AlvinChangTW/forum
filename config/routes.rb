Rails.application.routes.draw do
  devise_for :users
  resources :topics do
    resources :comments, :controller => "topic_comments"
    collection do
      get :about
    end
  end
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "topics#index"
end
