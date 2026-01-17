class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.string :company_name
      t.string :role
      t.date :due_date
      t.date :applied_on
      t.integer :status
      t.integer :interviews_count

      t.timestamps
    end
  end
end
