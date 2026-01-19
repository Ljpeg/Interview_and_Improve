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
  belongs_to :interview, required: true, class_name: "Interview", foreign_key: "interview_id"

  enum :primary_gap, [:technical_skills, :communication, :experience, :problem_solving, :preparation, :other
]
  def went_poorly_if_rejected
    return unless interview&.rejected?

    if negative_notes.blank?
      errors.add(:negative_notes, "You must record what went poorly if an interview is rejected")
    end
  end
end
