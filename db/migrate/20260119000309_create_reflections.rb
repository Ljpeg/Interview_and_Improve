class CreateReflections < ActiveRecord::Migration[8.0]
  def change
    create_table :reflections do |t|
      t.integer :interview_id
      t.text :positive_notes
      t.text :negative_notes
      t.integer :primary_gap

      t.timestamps
    end
  end
end
