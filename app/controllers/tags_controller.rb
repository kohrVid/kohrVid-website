class TagsController < ApplicationController
  before_action :admin_user_404, except: [:index, :show]

  def index
    @tags = Tag.all.includes(:posts).order(:name)
  end

  def show
    @tag = Tag.includes(:posts).find(params[:id])
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
      flash.now[:error] = "An error has prevented this tag from being saved"
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
      flash.now[:error] = "Unable to update tag."
      render :edit
    end
  end

  def destroy
    Tag.find(params[:id]).destroy
    flash[:success] = "Tag deleted."
    redirect_to tags_url
  end

  private
    def tag_params
      params.require(:tag).permit(:name)
    end
end
