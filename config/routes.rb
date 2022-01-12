Rails.application.routes.draw do
  # Hash symbol # in Ruby represents a method. As you remember an action is just a public method,
  # so pages# index says “call the PagesController and its public method (action) index.”
  root to: 'pages#index'
end
