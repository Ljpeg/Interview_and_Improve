class InterviewsController < ApplicationController
  def index
    matching_interviews = Interview.all

    @list_of_interviews = matching_interviews.order({ :created_at => :desc })

    render({ :template => "interview_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_interviews = Interview.where({ :id => the_id })

    @the_interview = matching_interviews.at(0)

    render({ :template => "interview_templates/show" })
  end

  def create
    the_interview = Interview.new
    the_interview.application_id = params.fetch("query_application_id")
    the_interview.interview_type = params.fetch("query_interview_type")
    the_interview.date_of = params.fetch("query_date_of")
    the_interview.outcome = params.fetch("query_outcome")
    the_interview.notes = params.fetch("query_notes")

    if the_interview.valid?
      the_interview.save
      redirect_to("/interviews", { :notice => "Interview created successfully." })
    else
      redirect_to("/interviews", { :alert => the_interview.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_interview = Interview.where({ :id => the_id }).at(0)

    the_interview.application_id = params.fetch("query_application_id")
    the_interview.interview_type = params.fetch("query_interview_type")
    the_interview.date_of = params.fetch("query_date_of")
    the_interview.outcome = params.fetch("query_outcome")
    the_interview.notes = params.fetch("query_notes")

    if the_interview.valid?
      the_interview.save
      redirect_to("/interviews/#{the_interview.id}", { :notice => "Interview updated successfully." } )
    else
      redirect_to("/interviews/#{the_interview.id}", { :alert => the_interview.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_interview = Interview.where({ :id => the_id }).at(0)

    the_interview.destroy

    redirect_to("/interviews", { :notice => "Interview deleted successfully." } )
  end
end
