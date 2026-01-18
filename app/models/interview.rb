# == Schema Information
#
# Table name: interviews
#
#  id             :bigint           not null, primary key
#  date_of        :date
#  interview_type :integer
#  notes          :text
#  outcome        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  application_id :integer
#
class Interview < ApplicationRecord
  belongs_to :job_application, class_name: "JobApplication", foreign_key: "application_id", counter_cache: true
  enum :outcome, [:pending, :passed, :rejected]
  validates :interview_type, presence: true
end
