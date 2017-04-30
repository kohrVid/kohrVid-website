Rails.application.routes.draw do
  root 'nest#index'

  devise_scope :user do
    devise_for :users, controllers: {
      sessions: 'devise/sessions',
      registrations: 'devise/registrations',
      passwords: 'devise/passwords',
      confirmations: 'devise/confirmations',
      unlocks: 'devise/unlocks'
    }, via: [:get, :post, :delete]
    as :user do
      get 'login' => 'devise/sessions#new'
      get 'sign_up' => 'devise/registrations#new'
      get 'log_out' => 'devise/sessions#destroy'
      resources :users
    end
  end

  get 'about'   =>  'nest#about'
  get 'contact'	=>  'contacts#new'
  resources 'contacts', only: [ :new, :create ]
  resources 'clients'
  get 'clients/list' =>  'clients#list'
  get 'blog' =>  'posts#index'
  
  scope '/blog' do
    resources :posts do
      resources :comments, only: [:index, :create, :edit, :update]
      get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
    end
    resources :tags
  end

  resources :comments, only: [:index, :create, :edit, :update]
  get '/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
end
