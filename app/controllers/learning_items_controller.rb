class LearningItemsController < ApplicationController
  def index
    matching_learning_items = LearningItem.all

    @list_of_learning_items = matching_learning_items.order({ :created_at => :desc })

    render({ :template => "learning_item_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_learning_items = LearningItem.where({ :id => the_id })

    @the_learning_item = matching_learning_items.at(0)

    render({ :template => "learning_item_templates/show" })
  end

  def create
    the_learning_item = LearningItem.new
    the_learning_item.reflection_id = params.fetch("query_reflection_id")
    the_learning_item.category = params.fetch("query_category")
    the_learning_item.description = params.fetch("query_description")
    the_learning_item.status = params.fetch("query_status")

    if the_learning_item.valid?
      the_learning_item.save
      redirect_to("/learning_items", { :notice => "Learning item created successfully." })
    else
      redirect_to("/learning_items", { :alert => the_learning_item.errors.full_messages.to_sentence })
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
