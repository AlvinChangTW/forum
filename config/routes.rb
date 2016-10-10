Rails.application.routes.draw do
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
