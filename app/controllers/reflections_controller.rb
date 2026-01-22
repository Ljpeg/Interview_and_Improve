class ReflectionsController < ApplicationController
  before_action :set_reflection

  def new
    @reflection = @interview.build_reflection
  end

  def show
    @reflection = @interview.reflection
    @learning_items = @reflection.learning_items
  end

  def create
    @reflection = @interview.build_reflection(reflection_params)

    if @reflection.valid?
      @reflection.save 
      redirect_to interview_url(@interview),  notice: "Reflection created successfully." 
    else
      render "reflections/new"
    end
  end
  
  def edit
    @reflection = @interview.reflection
  end 

  def update
    @reflection.assign_attributes(reflection_params)

    if @reflection.valid?
      @reflection.save
      redirect_to interview_reflection_path, notice:  "Reflection updated successfully."
    else
      redirect_to interview_reflection_path, alert:  @reflection.errors.full_messages.to_sentence
    end
  end

  def destroy
    @reflection.destroy

    redirect_to interview_url(@reflection.interview), notice: "Reflection deleted successfully."
  end

  private 

  def set_reflection
    @interview = find_scoped!(
      Interview.within_job_applications(job_application_scope),
      id: params.fetch(:interview_id)
    )
    @reflection = @interview.reflection
    @job_application = @interview.job_application
  end 


  def reflection_params
    params.require(:reflection).permit(:positive_notes, :negative_notes, :primary_gap)
  end
  
end
