Rails.application.routes.draw do
  root 'home#index'
  resources :enrolls
  resources :students
  resources :courses
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end