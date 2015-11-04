class ClientsController < ApplicationController
	before_action :set_client, only: [:show, :edit, :update, :destroy]
	def index
		@clients = Client.all
	end
	def list
		if current_user && current_user.admin?
			@clients = Client.all
		else
			render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
		end
	end

	def show
		if current_user && current_user.admin?
			@client = Client.find(params[:id])
		else
			render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
		end
	end

	def new
		if current_user && current_user.admin?
			@client = Client.new
			@object = @client
			render 'new'
		else
			render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
		end
	end

	def create
		@client = Client.new(client_params)
		@object = @client
		if @client.save && remotipart_submitted?
			render 'index'
			flash.now[:success] = "Client has been succesfully added"
		elsif !remotipart_submitted?
			flash.now[:error] = "Client has been created but remotipart has not been submitted"
			render 'index'
		else
			flash.now[:error] = "An error has prevented this client from being created."
			render 'new'
		end
	end

	def edit
		@client = Client.find(params[:id])
		if current_user && current_user.admin?
			render 'edit'
		else
			render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
		end
	end

	def update
		@client = Client.find(params[:id])
		@object = @client
		if @client.update(client_params) && remotipart_submitted?
			flash.now[:success] = "Client was successfully updated."
			render 'show'
		elsif !remotipart_submitted?
			flash.now[:error] = "Client has been created but remotipart has not been submitted"
			render 'show'
		else
			flash.now[:error] = "An error has prevented this client from being updated."
			render 'edit'
		end
	end

	def destroy
		if current_user && current_user.admin?
			@client = Client.find(params[:id])
			@client.destroy
			redirect_to clients_path
			flash.now[:notice] = 'Client was successfull destroyed.'
		end
	end



	private

		def set_client
			@client = Client.find(params[:id])
		end

		def client_params
			params.require(:client).permit(:client_name, :client_url, :image_url, :logo_url, :description, :pdf)
		end
end
