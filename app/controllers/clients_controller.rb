class ClientsController < ApplicationController
	before_action :set_client, only: [:show, :edit, :update, :destroy]
	def index
		@clients = Client.all
	end
	def list
		@clients = Client.all
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
		if @client.save
			redirect_to @client
			flash.now[:success] = "Client has been succesfully added"
		else
			render :new
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
		if @client.update(client_params)
			redirect_to @client
			flash.now[:success] = "Client was successfully updated."
		else
			render :edit
		end
	end

	def destroy
		if @client.update(client_params)
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
			params.require(:client).permit(:client_name, :client_url, :image_url, :logo_url, :description)
		end
end
