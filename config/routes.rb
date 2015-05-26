Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :doctors, :controllers => { :registrations => 'registrations' }

  root 'home#index'

  get 'home/index'

  get 'home/survey'
  get 'home/init'
  get 'home/survey_step'
  post 'home/survey_step'

  authenticate(:doctor) do
    get 'home/dashboard'
    resources :surveys, only: [:show, :index, :destroy]
  end
end
