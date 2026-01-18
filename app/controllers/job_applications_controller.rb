class JobApplicationsController < ApplicationController
  def new
    @job_application = JobApplication.new
  end

  def index
    @job_applications = JobApplication.all.order({ created_at: :desc })
  end

  def show
    @job_application = JobApplication.find(params.fetch(:id))
  end

  def create
    job_application_attributes = params.require(:job_application).permit(:company_name, :role, :due_date, :applied_on, :status)
    @job_application = JobApplication.new(job_application_attributes)
    @job_application.user_id = current_user.id

    if @job_application.valid?
      @job_application.save
      redirect_to job_applications_url, notice: "Job application created successfully."
    else
      render "job_applications/new"
    end
  end

  def edit
    @job_application = JobApplication.find(params.fetch(:id))
  end

  def update
    job_application = JobApplication.find(params.fetch(:id))
    job_application_attributes = params.require(:job_application).permit(:company_name, :role, :due_date, :applied_on, :status)
    job_application.assign_attributes(job_application_attributes)
    job_application.user_id = current_user.id

    if job_application.valid?
      job_application.save
      redirect_to job_applications_url(job_application.id), notice: "Job application updated successfully."
    else
      redirect_to job_applications_url(job_application.id), alert: job_application.errors.full_messages.to_sentence
    end
  end

  def destroy
    job_application = JobApplication.find(params.fetch(:id))
    job_application.destroy

    redirect_to job_applications_url, notice: "Job application deleted successfully."
  end
end
