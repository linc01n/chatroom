Rails.application.routes.draw do
  root to: 'rooms#show'

  mount ActionCable.server => '/cable'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
