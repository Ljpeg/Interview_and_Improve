class LearningItemsController < ApplicationController
  def new
    @interview = Interview.find(params.fetch(:interview_id))
    @learning_item = @interview.reflection.learning_items.build
  end 

  def index
    @interview = Interview.find(params.fetch(:interview_id))
    @learning_items = LearningItem.all.order({ created_at: :desc })
  end

  def show
    @learning_item = LearningItem.find(params.fetch(:id))
    @interview = @learning_item.reflection.interview
  end

  def create
    @interview = Interview.find(params.fetch(:interview_id))
    learning_item_attributes = params.require(:learning_item).permit(:category, :description, :status)
    @learning_item = @interview.reflection.learning_items.build(learning_item_attributes)

    if @learning_item.valid?
      @learning_item.save
      redirect_to interview_reflection_path(@learning_item.reflection.interview.id), notice: "Learning item created successfully." 
    else
      render "learning_items/new"
    end
  end

  def edit
    @learning_item = LearningItem.find(params.fetch(:id))
  end

  def update
    @learning_item = LearningItem.find(params.fetch(:id))
    learning_item_attributes = params.require(:learning_item).permit(:category, :description, :status)
    @learning_item.assign_attributes(learning_item_attributes)

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
end
