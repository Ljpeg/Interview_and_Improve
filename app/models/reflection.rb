# == Schema Information
#
# Table name: reflections
#
#  id             :bigint           not null, primary key
#  negative_notes :text
#  positive_notes :text
#  primary_gap    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  interview_id   :integer
#
class Reflection < ApplicationRecord
  belongs_to :interview, class_name: "Interview", foreign_key: "interview_id"
  has_many :learning_items, dependent: :destroy

  enum :primary_gap, [:technical_skills, :communication, :experience, :problem_solving, :preparation, :other]

  scope :within_job_applications, ->(job_apps) {
    joins(interview: :job_application).merge(job_apps)
  }

  def went_poorly_if_rejected
    return unless interview&.rejected?

    if negative_notes.blank?
      errors.add(:negative_notes, "You must record what went poorly if an interview is rejected")
    end
  end
end
