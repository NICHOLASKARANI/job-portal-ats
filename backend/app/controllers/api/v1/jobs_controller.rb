class Api::V1::JobsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show, :search]
  before_action :set_job, only: [:show, :update, :destroy]
  
  def index
    jobs = Job.active.recent
    jobs = jobs.where(employment_type: params[:employment_type]) if params[:employment_type].present?
    jobs = jobs.where(location: params[:location]) if params[:location].present?
    
    render json: jobs
  end
  
  def search
    jobs = Job.search_jobs(params[:q]).active.limit(10)
    render json: jobs
  end
  
  def show
    render json: @job
  end
  
  def create
    if current_user.employer?
      job = current_user.employer_profile.jobs.new(job_params)
      if job.save
        render json: job, status: :created
      else
        render json: { errors: job.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Only employers can create jobs' }, status: :unauthorized
    end
  end
  
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @job.destroy
    head :no_content
  end
  
  private
  
  def set_job
    @job = Job.find(params[:id])
  end
  
  def job_params
    params.permit(:title, :description, :requirements, :location, :salary_range, 
                  :employment_type, :expiry_date, :status)
  end
end