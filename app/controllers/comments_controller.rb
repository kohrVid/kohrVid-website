class CommentsController < ApplicationController
	before_action :friendly_id
	before_action :correct_user, only: [:edit, :update]
	
	def index
		@comments = Comment.hash_tree
	end

	def new
		@comment = Comment.new(parent_id: params[:parent_id], post_id: @post.id)
		@comment.user_id = current_user.id unless !user_signed_in?
	end

	def create
		if params[:comment][:parent_id].to_i > 0
			parent = Comment.find_by_id(params[:comment].delete(:parent_id))
			@comment = parent.children.build(comment_params)
		else
			@comment = Comment.new(comment_params)
		end

		@comment.user_id = current_user.id unless !user_signed_in?
		@comment.post_id = @post.id

		if @comment.save
			flash[:success] =  "Your comment was added successfully!"
			redirect_to post_path(@post)
		else
			flash.now[:error] = "Unable to post comment."
			render :new
		end
	end

	def edit
	end

	def update
		if @comment.update_attributes(comment_params)
			flash[:success] =  "Your comment was updated successfully!"
			redirect_to post_path(@post)
		else
			flash.now[:error] = "Unable to edit comment."
			render :edit
		end
	end


	private
		def comment_params
			params.require(:comment).permit(:author, :body, :user_id, :post_id, :parent_id)
		end

		def friendly_id
			@post = Post.friendly.find(params[:post_id])
		end
		
		def correct_user
			@comment = Comment.find(params[:id])
			unless current_user.id == @comment.user_id
				flash[:error] = "Sorry, you do not have access to that part of the site."
				redirect_to(root_url)
			end
		end
end
