Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

#.....USER
  post 'user_login', to: 'users#login'
  resource :users

#....COURSE
  resources :courses

#....ENROLLMENT
  resources :enrollments
 
end
