Rails.application.routes.draw do
  get '/robots.txt', to: 'robots#index'

  constraints subdomain: /^(?!www|natty|blog)(\w+)/ do
    get '/', to: redirect { |params, request|
      "http://#{Rails.env.development? ? 'natty.dev' : 'natty.in'}/stores/#{request.subdomain}"
    }
  end

  mount Spree::Core::Engine, at: '/'
end

Spree::Core::Engine.routes.draw do
  get '/shop/*id', to: 'taxons#show', as: :shop
  get '/search', to: 'search#index'
  get '/aboutus', to: 'static_pages#aboutus'
  get '/partnerships', to: 'static_pages#partnerships'
  get '/careers', to: 'static_pages#careers'
  get '/contact', to: 'static_pages#contact'
  post '/contact_submit', to: 'static_pages#contact_submit'
  patch '/contact_submit', to: 'static_pages#contact_submit'
  get '/whyshopwithus', to: 'static_pages#whyshopwithus'
  get '/faqs', to: 'static_pages#faqs'
  get '/shippingreturns', to: 'static_pages#shippingreturns'
  resource :newsletter_signup, only: :create
  get '/variant', to: 'products#variant'
  resources :stores, only: [:index, :show] do
    resources :products, only: [:index, :show] do
      get 'question'
    end
  end
  scope '/filter' do
    get 'stores', to: 'stores#filter'
  end
  get '/categories', to: 'taxons#index'

  devise_scope :spree_user do
    get '/signup_seller', to: 'user_registrations#new', as: :signup_seller
    get '/learn_more', to: 'user_registrations#new', as: :learn_more
    get '/about_toolkit', to: 'user_registrations#new', as: :about_toolkit
    post '/checkout/update/confirm', to: 'checkout#payu', as: :checkout_confirm_path
  end

  namespace :supplier do
    get '/slug_availability', to: 'stores#slug'
    resources :stores, only: [:new, :create, :show, :edit, :update] do
      resources :option_types, except: [:new, :create, :show] do
      end
      # resources :prototypes, except: [:new, :show]
      resources :products, except: [:show] do
        resources :variants, except: [:new, :show]
      end
      resources :stocks, only: [:index, :edit, :update], as: :stock_items
      get 'orders_pending', to: 'orders#pending'
      get 'orders_fulfilled', to: 'orders#fulfilled'
      resources :orders, only: :show do
        post 'ship'
      end
      get 'settings/store', to: 'settings#store_edit'
      patch 'settings/store', to: 'settings#store_update'
      get 'settings/banking', to: 'settings#banking_edit'
      patch 'settings/banking', to: 'settings#banking_update'
      get 'settings/policies', to: 'settings#policies_edit'
      patch 'settings/policies', to: 'settings#policies_update'
    end
  end

  namespace :admin do
    get 'newsletter_signup', to: 'newsletter_signup#index'
    resources :stores, only: [:index, :show, :edit, :update]
    get 'pending_stores', to: 'stores#pending', as: :pending_stores
    get 'approved_stores', to: 'stores#approved', as: :approved_stores
    get 'featured_stores', to: 'stores#featured', as: :featured_stores
    get 'pending_products', to: 'products#pending', as: :pending_products
    get 'approved_products', to: 'products#approved', as: :approved_products
  end
end

Spree::Core::Engine.add_routes do
  devise_for :spree_users,
    class_name: Spree::User,
    only: [:omniauth_callbacks],
    controllers: { omniauth_callbacks: 'spree/omniauth_callbacks' }
end
