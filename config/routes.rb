require 'sidekiq/web'
Antimony::Application.routes.draw do
  mount Sidekiq::Web, at: "/sidekiq"
  resources :galleries do
    member do
      put 'add_photo', :as => 'add_photo_to'
      put 'remove_photo', :as => 'remove_photo_from'
    end
  end


  resources :photos


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'users/:id' => 'users#show', :as => 'user'
  get 'users/:id/photos' => 'users#photos', :as => 'user_photos'
  get 'users/:id/galleries' => 'users#galleries', :as => 'user_galleries'
  get 'users/:id/uncategorized' => 'users#uncategorized', :as => 'user_uncategorized_photos'
  get "home/index"
  get 'users/:id/edit_photos' => 'users#edit_photos', :as => 'edit_photos'
  # root to: 'photos#index'
  root to: 'home#index'
end
