Rails.application.routes.draw do
  get 'doctors/new'
  get 'doctors/edit'
  get 'doctors/show'

  resources :doctors
  root 'doctors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
