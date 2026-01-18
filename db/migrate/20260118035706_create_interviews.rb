class CreateInterviews < ActiveRecord::Migration[8.0]
  def change
    create_table :interviews do |t|
      t.integer :application_id
      t.integer :interview_type
      t.date :date_of
      t.integer :outcome
      t.text :notes

      t.timestamps
    end
  end
end
