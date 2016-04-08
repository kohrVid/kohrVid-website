class TagsController < ApplicationController
	before_action :admin_user_404, except: [:index, :show]

	def index
		@tags = Tag.all
	end

	def show
		@tag = Tag.find(params[:id])
	end

	def new
		@tag = Tag.new
	end

	def create
		@tag = Tag.new(tag_params)
		if @tag.save
			flash[:success] = "Tag was created successfully."
			redirect_to @tag
		else
			flash[:error] = "An error has prevented this tag from being saved"
			render :new
		end
	end

	def edit
		@tag = Tag.find(params[:id])
	end

	def update
		@tag = Tag.find(params[:id])
		if @tag.update_attributes(tag_params)
			flash[:success] = "Tag updated."
			redirect_to @tag
		else
			flash[:error] = "Unable to update tag."
			render :edit
		end
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy
		flash[:success] = "Tag deleted."
		redirect_to tags_url
	end

	private
		def tag_params
			params.require(:tag).permit(:name)
		end
end
