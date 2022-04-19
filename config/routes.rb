Rails.application.routes.draw do
  match 'channel-icon/checkblock', to: 'channel_icon#check_block', via: [:get, :post, :options ]
  match 'channel-icon/findmissing', to: 'channel_icon#find_missing', via: [:get, :post, :options ]
  match 'channel-icon/lookup', to: 'channel_icon#lookup', via: [:get, :post, :options ]
  match 'channel-icon/master-iconmap', to: 'channel_icon#master_iconmap', via: [:get, :head ]
  match 'channel-icon/ping', to: 'channel_icon#ping', via: [:get ]
  match 'channel-icon/search', to: 'channel_icon#search', via: [:get, :post, :options ]
  match 'channel-icon/sources', to: 'channel_icon/sources#index', via: [:get, :head ]
  match 'channel-icon/submit', to: 'channel_icon#submit', via: [:post, :options ]
  match 'channel-icon/edit', to: 'channel_icon/editor#index', via: [:get]

  namespace :music do
    match 'data/index', to: 'data#index', via: [:get, :head ]
    match 'data', to: 'data#index', via: [:get, :head ]
  end

  namespace :samples do
    match 'video/index', to: 'video#index', via: [:get, :head ]
    match 'video', to: 'video#index', via: [:get, :head ]
  end

  root 'root#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
