# == Schema Information
#
# Table name: learning_items
#
#  id            :bigint           not null, primary key
#  category      :integer
#  description   :text
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  reflection_id :integer
#
class LearningItem < ApplicationRecord
  belongs_to :reflection, class_name: "Reflection", foreign_key: "reflection_id"

  enum :category, [:technical, :behavioral, :system_design, :other]
  enum :status, [:unaddressed, :pending, :improved]
  
  validates :description, :status, presence: true
  
  scope :within_job_applications, ->(job_apps) {
    joins(reflection: { interview: :job_application }).merge(job_apps)
  }
end
