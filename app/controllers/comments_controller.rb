class CommentsController < ApplicationController
	before_action :friendly_id
	
	def index
		@comments = Comment.hash_tree
	end

	def new
		@comment = Comment.new(parent_id: params[:parent_id], post_id: @post.id)
	end

	def create
		if params[:comment][:parent_id].to_i > 0
			parent = Comment.find_by_id(params[:comment].delete(:parent_id))
			@comment = parent.children.build(comment_params)
		else
			@comment = Comment.new(comment_params)
		end

		@comment.user_id = current_user.id
		@comment.post_id = @post.id

		if @comment.save
			flash[:success] =  "Your comment was added successfully!"
			redirect_to post_path(@post)
		else
			render :new
		end
	end


	private
		def comment_params
			params.require(:comment).permit(:author, :body, :user_id, :post_id)
		end

		def friendly_id
			@post = Post.friendly.find(params[:post_id])
		end
end
