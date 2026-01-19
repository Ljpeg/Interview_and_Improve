class ReflectionsController < ApplicationController
  def new
    @interview = Interview.find(params.fetch(:interview_id))
    @reflection = @interview.build_reflection
  end

  def show
    @interview = Interview.find(params.fetch(:interview_id))
    @reflection = @interview.reflection
  end

  def create
    @interview = Interview.find(params.fetch(:interview_id))
    reflection_attributes = params.require(:reflection).permit(:positive_notes, :negative_notes, :primary_gap)
    @reflection = @interview.build_reflection(reflection_attributes)

    if @reflection.valid?
      @reflection.save 
      redirect_to interview_url(@interview),  notice: "Reflection created successfully." 
    else
      render "reflections/new"
    end
  end
  
  def edit
    @interview = Interview.find(params.fetch(:interview_id))
    @reflection = @interview.reflection
  end 

  def update
    @interview = Interview.find(params.fetch(:interview_id))
    reflection_attributes = params.require(:reflection).permit(:positive_notes, :negative_notes, :primary_gap)
    @reflection = @interview.build_reflection(reflection_attributes)

    if @reflection.valid?
      @reflection.save
      redirect_to interview_reflection_path, notice:  "Reflection updated successfully."
    else
      redirect_to interview_reflection_path, alert:  @reflection.errors.full_messages.to_sentence
    end
  end

  def destroy
    @interview = Interview.find(params.fetch(:interview_id))
    @reflection = @interview.reflection

    @reflection.destroy

    redirect_to interview_url(@reflection.interview), notice: "Reflection deleted successfully."
  end
end
