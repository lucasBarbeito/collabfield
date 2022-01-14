Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  root to: 'pages#index'
  devise_scope :user do
    get 'login',  to: 'devise/sessions#new'
    get 'signUp', to: 'devise/registrations#new'
  end
end
