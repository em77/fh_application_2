Rails.application.routes.draw do
  # get 'pages/home'
  root to: "member_applications#new"
  resources :member_applications, except: [:destroy, :index]
  controller :member_applications do
    get :pdf
  end
end
