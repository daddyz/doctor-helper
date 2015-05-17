Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :doctors, :controllers => { :registrations => 'registrations' }

  root 'home#index'

  get 'home/index'

  authenticate(:doctor) do
    get 'home/dashboard'
  end
end
