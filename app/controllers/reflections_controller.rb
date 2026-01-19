class ReflectionsController < ApplicationController
  def index
    matching_reflections = Reflection.all

    @list_of_reflections = matching_reflections.order({ :created_at => :desc })

    render({ :template => "reflection_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_reflections = Reflection.where({ :id => the_id })

    @the_reflection = matching_reflections.at(0)

    render({ :template => "reflection_templates/show" })
  end

  def create
    the_reflection = Reflection.new
    the_reflection.interview_id = params.fetch("query_interview_id")
    the_reflection.positive_notes = params.fetch("query_positive_notes")
    the_reflection.negative_notes = params.fetch("query_negative_notes")
    the_reflection.primary_gap = params.fetch("query_primary_gap")

    if the_reflection.valid?
      the_reflection.save
      redirect_to("/reflections", { :notice => "Reflection created successfully." })
    else
      redirect_to("/reflections", { :alert => the_reflection.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_reflection = Reflection.where({ :id => the_id }).at(0)

    the_reflection.interview_id = params.fetch("query_interview_id")
    the_reflection.positive_notes = params.fetch("query_positive_notes")
    the_reflection.negative_notes = params.fetch("query_negative_notes")
    the_reflection.primary_gap = params.fetch("query_primary_gap")

    if the_reflection.valid?
      the_reflection.save
      redirect_to("/reflections/#{the_reflection.id}", { :notice => "Reflection updated successfully." } )
    else
      redirect_to("/reflections/#{the_reflection.id}", { :alert => the_reflection.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_reflection = Reflection.where({ :id => the_id }).at(0)

    the_reflection.destroy

    redirect_to("/reflections", { :notice => "Reflection deleted successfully." } )
  end
end
