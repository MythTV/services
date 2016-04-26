Rails.application.routes.draw do
  match 'channel-icon/checkblock', to: 'channel_icon#check_block', via: [:get, :head ]
  match 'channel-icon/findmissing', to: 'channel_icon#find_missing', via: [:get, :post ]
  match 'channel-icon/lookup', to: 'channel_icon#lookup', via: [:get, :post ]
  match 'channel-icon/master-iconmap', to: 'channel_icon#master_iconmap', via: [:get, :head ]
  match 'channel-icon/ping', to: 'channel_icon#ping', via: [:get ]
  match 'channel-icon/search', to: 'channel_icon#search', via: [:get, :post ]
  match 'channel-icon/sources', to: 'channel_icon/sources#index', via: [:get, :head ]
  match 'channel-icon/submit', to: 'channel_icon#submit', via: [:post ]

  namespace :music do
    match 'data/index', to: 'data#index', via: [:get, :head ]
    match 'data', to: 'data#index', via: [:get, :head ]
  end

  namespace :samples do
    match 'video/index', to: 'video#index', via: [:get, :head ]
    match 'video', to: 'video#index', via: [:get, :head ]
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'samples/video#index'

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
