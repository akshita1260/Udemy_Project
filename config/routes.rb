Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #.....INSTRUCTOR
  #   post 'instructor_login', to: 'instructors#login'
  #   get 'instructor_update', to: 'instructors#update'
  #   # get 'show',to: 'instructors#show'
  #   # get 'update',to: 'instructors#update'
  #   # get 'destroy',to: 'instructors#destroy'
  #   resource :instructors

  # #....STUDENT
  #   post 'student_login', to: 'students#login'
  #   get 'student_update', to: 'students#update'
  #   get 'show_student',to: 'students#show'
  #   get 'update_student',to: 'students#update'
  #   get 'destroy_student',to: 'students#destroy'
  #   resources :students
  post 'user_login', to: 'users#login'
   resource :users

  #....COURSE
    get 'course_status', to: 'courses#course_by_status'
    get 'active_status', to: 'courses#course_by_active_status'
    get 'course_category', to: 'courses#course_by_category'
    get 'name_category', to: 'courses#course_by_name_and_category'
    resources :courses

  #....ENROLLMENT
    get 'enroll_status_update/:id', to: 'enrollments#update_student_course_status'
    resources :enrollments
 
end
