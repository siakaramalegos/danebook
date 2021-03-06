Rails.application.routes.draw do

  get 'newsfeed' => 'newsfeed#newsfeed'

  resources :users, only: [:new, :create, :index, :update] do
    resources :posts, only: [:index, :create, :show], path: :timeline
    resources :photos, only: [:index, :show]
    resources :comments, only: [:show]
    get 'friends' => 'friends#index'
  end

  resources :posts, only: [:destroy] do
    resources :comments, only: [:create]
    resource :like, only: [:create, :destroy]
  end

  resources :comments, only: [:destroy] do
    resource :like, only: [:create, :destroy]
  end

  resources :photos, only: [:create, :destroy] do
    resource :comment, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end

  resources :profiles, only: [:show, :edit, :update], path: :about
  resource :friend, only: [:create, :destroy]

  resource :session, only: [:create, :destroy]
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'home' => 'users#new'

  get 'photos' => 'static_pages#photos'

  root 'users#new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
