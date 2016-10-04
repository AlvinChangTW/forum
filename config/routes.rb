Rails.application.routes.draw do
  resources :topics do
    resources :comments, :controller => "topic_comments"
  end
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
