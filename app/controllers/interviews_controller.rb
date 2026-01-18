class InterviewsController < ApplicationController
  def new
    @interview = Interview.new
    @job_application = JobApplication.find(params.fetch(:job_application_id))
  end 

  def index
   @interviews = Interview.all.order({ created_at: :desc })
   @job_application = JobApplication.find(params.fetch(:job_application_id))
  end

  def show
    @interview = Interview.find(params.fetch(:id))
    @job_application = JobApplication.find(params.fetch(:job_application_id))

  end

  def create
    interview_attributes = params.require(:interview).permit(:interview_type, :date_of, :outcome, :notes)
    @interview = Interview.new(interview_attributes)
    job_application = JobApplication.find(params.fetch(:job_application_id))
    @interview.application_id = job_application.id

    if @interview.valid?
      @interview.save
      redirect_to job_application_interviews_url, notice: "Interview created successfully."
    else
      render "interviews/new"
    end
  end

  def edit
    @interview = Interview.find(params.fetch(:id))
    @job_application = JobApplication.find(params.fetch(:job_application_id))
  end

  def update
    interview = Interview.find(params.fetch(:id))
    interview_attributes = params.require(:interview).permit(:interview_type, :date_of, :outcome, :notes)
    interview.assign_attributes(interview_attributes)

    if interview.valid?
      interview.save
      redirect_to job_application_interview_url([interview.application_id, interview.id]), notice: "Interview updated successfully." 
    else
      redirect_to job_application_interview_url([interview.application_id, interview.id]), alert: interview.errors.full_messages.to_sentence
    end
  end

  def destroy
    interview = Interview.find(params.fetch(:id))
    interview.destroy

    redirect_to job_application_interviews_url, notice: "Interview deleted successfully."
  end
end
