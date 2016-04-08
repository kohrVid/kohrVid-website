Rails.application.routes.draw do
	root "nest#index"

	devise_for :users, controllers: {
		        sessions: 'devise/sessions',
				  registrations: "devise/registrations",
				  passwords: "devise/passwords",
				  confirmations: "devise/confirmations",
#				  omniauth_callbacks: "devise/omniauth_callbacks",
				  unlocks: "devise/unlocks"
				        }

	devise_scope :user do
		get "sign_up"		=> "devise/registrations#new"
		get "log_in"			=> "devise/sessions#new"
		get "log_out", :to => "devise/sessions#destroy"
	end
	resources :users
	get 	"about" 			=>  "nest#about"
	get 	"contact"	 	=>  "contacts#new"
	resources "contacts", 	only: [:new, :create]
	resources "clients"
	get 	"clients/list" =>  "clients#list"
	get	"blog"			=>  "posts#index"
	scope "/blog" do
		resources :posts do
			resources :comments, only: [:index, :create, :edit, :update]
			get "/comments/new/(:parent_id)", to: "comments#new", as: :new_comment
		end
		resources :tags
	end
	resources :comments, only: [:index, :create, :edit, :update]
	get "/comments/new/(:parent_id)", to: "comments#new", as: :new_comment
end
