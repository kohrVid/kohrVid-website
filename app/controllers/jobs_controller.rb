class JobsController < ApplicationController
  before_action :admin_user_404

  def index
    @jobs = Job.order(start_date: :desc)
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:success] = "Job was created successfully."
      redirect_to @job
    else
      flash.now[:error] = "An error has prevented this job from being saved"
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:success] = "Job updated."
      redirect_to @job
    else
      flash.now[:error] = "Unable to update job."
      render :edit
    end
  end

  def destroy
    Job.find(params[:id]).destroy
    flash[:success] = "Job deleted."
    redirect_to jobs_url
  end

  private

  def job_params
    params.require(:job).permit(
      :title,
      :company_name,
      :company_website,
      :start_date,
      :end_date,
      :description
    )
  end
end
