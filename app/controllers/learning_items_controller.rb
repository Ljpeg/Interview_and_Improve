class LearningItemsController < ApplicationController
  before_action :set_learning_item, only: [:show, :edit, :update, :destroy]
  before_action :set_interview, only: [:new, :index, :create]

  def new
    @learning_item = @reflection.learning_items.build
  end

  def index
    @learning_items = @reflection.learning_items
  end

  def show
  end

  def create
    @learning_item = @reflection.learning_items.build(learning_item_params)

    if @learning_item.valid?
      @learning_item.save
      redirect_to interview_reflection_path(@learning_item.reflection.interview.id), notice: "Learning item created successfully."
    else
      render "learning_items/new"
    end
  end

  def edit
  end

  def update
    @learning_item.assign_attributes(learning_item_params)

    if @learning_item.valid?
      @learning_item.save
      redirect_to learning_item_path(@learning_item.id), notice: "Learning item updated successfully."
    else
      redirect_to learning_item_path(@learning_item.id), alert: @learning_item.errors.full_messages.to_sentence
    end
  end

  def destroy
    @learning_item = LearningItem.find(params.fetch(:id))
    @learning_item.destroy

    redirect_to interview_reflection_path(@learning_item.reflection.interview.id), notice: "Learning item deleted successfully."
  end

  private

  def set_interview
    @interview = find_scoped!(
      Interview.within_job_applications(job_application_scope),
      id: params.fetch(:interview_id),
    )

    @reflection = @interview.reflection
    @job_application = @interview.job_application
  end

  def set_learning_item
    @learning_item = find_scoped!(
      LearningItem.within_job_applications(job_application_scope),
      id: params.fetch(:id),
    )
    @reflection = @learning_item.reflection
    @interview = @reflection.interview
    @job_application = @interview.job_application
  end

  def learning_item_params
    params.require(:learning_item).permit(:category, :description, :status)
  end
end
