class ClientsController < ApplicationController
  #before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :admin_user_404, except: :index

  def index
    @clients = Client.published
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @clients }
    end
  end

  def list
    @clients = Client.all.order(:id)
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
    render 'new'
  end

  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save# && remotipart_submitted?
        format.html { redirect_to clients_path, notice: "Client has been succesfully added" }
        format.js
        format.json { render status: 200, location: @client}
#		elsif @client.save && !remotipart_submitted?
#			format.js
#			flash.now[:error] = "Client has been created but remotipart has not been submitted"
#			render 'index'
      else
        format.html { render :new, error:  "An error has prevented this client from being created."}
        format.json {render json: @client.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @client = Client.find(params[:id])
    render 'edit'
  end

  def update
    @client = Client.find(params[:id])
    respond_to do |format|
      if @client.update(client_params)# && remotipart_submitted?
        format.html { redirect_to clients_path, notice: "Client was successfully updated." }
        format.js
        format.js { render status: 200, location: @client}
=begin
      elsif @client.update(client_params) && !remotipart_submitted?
              format.js
              flash.now[:error] = "Client has been created but remotipart has not been submitted"
              render 'show'
=end
      else
        format.html { render :edit, error:  "An error has prevented this client from being created."}
        format.json {render json: @client.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_path
    flash.now[:notice] = 'Client was successfully destroyed.'
  end



  private

  #		def set_client
  #			@client = Client.find(params[:id])
  #		end

  def client_params
    params.require(:client).permit(
      :name,
      :client_url,
      :image,
      :logo,
      :description,
      :pdf,
      :draft,
      :rank
    )
  end
end
