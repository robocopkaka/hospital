Rails.application.routes.draw do
  get 'home/index'
  devise_for :doctors, path_prefix: 'admin'
  devise_for :patients
  get 'patients/new'
  get 'patients/edit'
  get 'patients/show'
  get 'patients/index'
  get 'pending_appointments', to: 'appointments#pending_appointments'
  get 'appointment_history', to: 'appointments#appointment_history'
  get 'past_appointments', to: 'appointments#past_appointments'
  get 'future_appointments', to: 'appointments#future_appointments'
  get 'decline_appointment', to: 'appointments#decline_appointment'
  # get 'doctors/new'
  # get 'doctors/edit'
  # get 'doctors/show'

  resources :appointments, :specializations
  resources :patients do
    get 'appointments', on: :member
  end
  resources :doctors, except: :edit do
    get 'appointments', on: :member
  end
  resource :doctor, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
