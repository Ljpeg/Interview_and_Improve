class CreateLearningItems < ActiveRecord::Migration[8.0]
  def change
    create_table :learning_items do |t|
      t.integer :reflection_id
      t.integer :category
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
