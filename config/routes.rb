Rails.application.routes.draw do
  devise_for :users
  resources :users ,:only => [] do
  #:only => []讓其他原本的crud路徑失效，只留下member的profile
    member do
      get :profile
    end
  end
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
