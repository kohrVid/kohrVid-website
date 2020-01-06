class PostsController < ApplicationController
  before_action :admin_user_404, except: [:index, :show]
  before_action :friendly_finder, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_draft, only: [:show]

  def index
    @posts = Post.published.paginate(page: params[:page]).per_page(10)
  end

  def drafts
    @posts = Post.drafts.paginate(page: params[:page]).per_page(10)
  end

  def show
    @post = Post.includes(:tags).includes(:comments).friendly.find(params[:id])
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
      Tag.tag_relationship(@post)
      flash[:success] = "Post was created successfully."
      redirect_to @post
    else
      flash.now[:error] = "An error has prevented this post from being saved."
      render :new
    end
  end

  def edit
    @post = Post.includes(:tags).friendly.find(params[:id])
  end

  def update
    @post = Post.includes(:tags).friendly.find(params[:id])
    if @post.update(post_params)
      Tag.tag_relationship(@post)
      flash[:success] = "Post updated."
      redirect_to @post
    else
      flash.now[:error] = "Unable to update post."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post)
      .permit(
        :title,
        :body,
        :rich_text_body,
        :draft,
        :published_at,
        :tag_list
      )
  end

  def friendly_finder
    @post = Post.includes(:tags).includes(:comments).friendly.find(params[:id])
  end

  def redirect_if_draft
    friendly_finder
    unless @post.draft == false || (current_user && current_user.admin?) 
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
