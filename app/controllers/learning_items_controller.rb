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
  end

  def create
    @interview = Interview.find(params.fetch(:interview_id))
    learning_item_attributes = params.require(:learning_item).permit(:category, :description, :status)
    @learning_item = @interview.reflection.learning_items.build(learning_item_attributes)

    if @learning_item.valid?
      @learning_item.save
      redirect_to interview_reflection_learning_items_path, notice: "Learning item created successfully." 
    else
      render "learning_items/new"
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_learning_item = LearningItem.where({ :id => the_id }).at(0)

    the_learning_item.reflection_id = params.fetch("query_reflection_id")
    the_learning_item.category = params.fetch("query_category")
    the_learning_item.description = params.fetch("query_description")
    the_learning_item.status = params.fetch("query_status")

    if the_learning_item.valid?
      the_learning_item.save
      redirect_to("/learning_items/#{the_learning_item.id}", { :notice => "Learning item updated successfully." } )
    else
      redirect_to("/learning_items/#{the_learning_item.id}", { :alert => the_learning_item.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_learning_item = LearningItem.where({ :id => the_id }).at(0)

    the_learning_item.destroy

    redirect_to("/learning_items", { :notice => "Learning item deleted successfully." } )
  end
end
