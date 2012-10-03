Marianita::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  match 'auth/instagram/callback', to: 'auth/instagram#create'
  match 'auth/instagram', to: 'auth/instagram#new'
  # Only for twitter and facebook since we'll support signup/login with FB/Twitter only.
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :feeds, only: [ :index ]
end
