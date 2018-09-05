Rails.application.routes.draw do
  get 'patients/new'
  get 'patients/edit'
  get 'patients/show'
  get 'patients/index'
  get 'doctors/new'
  get 'doctors/edit'
  get 'doctors/show'

  resources :doctors
  resources :patients
  root 'doctors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
