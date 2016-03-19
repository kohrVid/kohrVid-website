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

	resources :users#, only: [:index, :show]
	get 	"about" 		=>  "nest#about"
	get 	"contact"	 	=>  "contacts#new"
	resources "contacts", 	only: [:new, :create]
	resources "clients"
	get 	"clients/list" 	=>  "clients#list"
#	get 	"login"  		=>  "users/sign_in" #"sessions#new"
#	post	"login"  		=>  "sessions#create"
#	get 	"login"  		=>  "sessions#new"
#	delete 	"logout"  		=>  "sessions#destroy"
#	get 	"signup" 		=>  "users/sign_up" #"users#new"
#	resources :account_activation, only: [:edit]
#	get 	"password_resets/new"
#	get 	"password_resets/edit"
#	resources :password_resets, only: [:new, :create, :edit, :update]

end
