class InterviewsController < ApplicationController
  before_action :set_job_application, only: [:index, :new, :create]
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  def new
    @interview = @job_application.interviews.build
  end 

  def index
   @interviews = @job_application.interviews
  end

  def show
  end

  def create
    @interview = @job_application.interviews.build(interview_params)

    if @interview.valid?
      @interview.save
      redirect_to job_application_interviews_url, notice: "Interview created successfully."
    else
      render "interviews/new"
    end
  end

  def edit
  end

  def update
    @interview.assign_attributes(interview_params)

    if @interview.valid?
      @interview.save
      redirect_to interview_url(@interview.id), notice: "Interview updated successfully." 
    else
      redirect_to interview_url(@interview.id), alert: @interview.errors.full_messages.to_sentence
    end
  end

  def destroy
    @interview.destroy
    
    redirect_to job_application_interviews_url(@interview.job_application), notice: "Interview deleted successfully."
  end

  private
  
  def set_job_application
    @job_application = job_application_scope.find(params.fetch(:job_application_id))
  end

  def set_interview
    @interview = find_scoped!(
      Interview.within_job_applications(job_application_scope),
      id: params.fetch(:id)
    )
    @job_application = @interview.job_application 
  end

  def interview_params
    params.require(:interview).permit(:interview_type, :date_of, :outcome, :notes)
  end 
end
