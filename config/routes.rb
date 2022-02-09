Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'pages#index'

  devise_scope :user do
    get 'login',  to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  resources :posts do
    #Here I’ve used a resources method to declare routes for index, show, new, edit, create, update and destroy actions.
    # Then I’ve declared some custom collection routes to access pages with multiple Post instances.
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  namespace :private do
    resources :conversations, only: [:create] do
      member do
        post :close
      end
    end
    resources :messages, only: [:index, :create]
  end

end
