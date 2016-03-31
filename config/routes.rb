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

	resources :users
	get 	"about" 			=>  "nest#about"
	get 	"contact"	 	=>  "contacts#new"
	resources "contacts", 	only: [:new, :create]
	resources "clients"
	get 	"clients/list" =>  "clients#list"
	get	"blog"			=>  "posts#index"
	scope "/blog" do
		resources :posts
	end
end
