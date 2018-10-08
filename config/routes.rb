Rails.application.routes.draw do
  devise_for :doctors
  devise_for :patients
  get 'patients/new'
  get 'patients/edit'
  get 'patients/show'
  get 'patients/index'
  # get 'doctors/new'
  # get 'doctors/edit'
  # get 'doctors/show'

  resources :appointments
  resources :patients do
    get 'appointments', on: :member
  end
  resources :doctors do
    get 'appointments', on: :member
  end
  root 'doctors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
