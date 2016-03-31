class PostsController < ApplicationController
	before_action :admin_user_404, except: [:index, :show]

	def index
		@posts = Post.all.where(draft: false).order("published_at DESC").paginate(page: params[:page])
	end

	def show
		@post = Post.find(params[:id])
		if @post.draft == true
			admin_user_404
		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			flash[:success] = "Post was created successfully."
			redirect_to @post
		else
			flash.now[:error] = "An error has prevented this post from being saved."
			render :new
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Post updated."
			redirect_to @post
		else
			flash.now[:error] = "Unable to update post."
			render :edit
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Post deleted."
		redirect_to posts_url
	end

	private
		def post_params
			params.require(:post).permit(:title, :body, :draft, :published_at)
		end
	
end
