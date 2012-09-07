Marianita::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
end
