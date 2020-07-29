Rails.application.routes.draw do
  get 'pages/home'

  resources :member_applications, except: [:destroy, :index]
end
