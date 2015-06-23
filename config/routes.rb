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
    get 'home/instructions'
    get 'home/qr_code'
    resources :surveys, only: [:show, :index, :destroy] do
      collection do
        get 'notifiable'
      end
    end
  end
end
