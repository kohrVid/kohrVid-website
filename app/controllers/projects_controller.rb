class ProjectsController < ApplicationController
  #before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :admin_user_404, except: :index

  def index
    @projects = Project.published
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @projects }
    end
  end

  def list
    @projects = Project.all.order(:id)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
    render 'new'
  end

  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save# && remotipart_submitted?
        format.html { redirect_to projects_path, notice: "Project has been succesfully added" }
        format.js
        format.json { render status: 200, location: @project}
#		elsif @project.save && !remotipart_submitted?
#			format.js
#			flash.now[:error] = "Project has been created but remotipart has not been submitted"
#			render 'index'
      else
        format.html { render :new, error:  "An error has prevented this project from being created."}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @project = Project.find(params[:id])
    render 'edit'
  end

  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update(project_params)# && remotipart_submitted?
        format.html { redirect_to projects_path, notice: "Project was successfully updated." }
        format.js
        format.js { render status: 200, location: @project}
=begin
      elsif @project.update(project_params) && !remotipart_submitted?
              format.js
              flash.now[:error] = "Project has been created but remotipart has not been submitted"
              render 'show'
=end
      else
        format.html { render :edit, error:  "An error has prevented this project from being created."}
        format.json {render json: @project.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
    flash.now[:notice] = 'Project was successfully destroyed.'
  end

  private

  #		def set_project
  #			@project = Project.find(params[:id])
  #		end

  def project_params
    params.require(:project).permit(
      :name,
      :repo_url,
      :app_url,
      :image,
      :description,
      :languages,
      :draft,
      :rank
    )
  end
end
