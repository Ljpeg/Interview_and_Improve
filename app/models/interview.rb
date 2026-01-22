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
  has_one :reflection, class_name: "Reflection", foreign_key: "interview_id", dependent: :destroy

  enum :outcome, [:pending, :passed, :rejected]
  enum :interview_type, [:screening, :technical, :behavorial, :final]

  validates :interview_type, presence: true

  scope :within_job_applications, ->(job_apps) {
          joins(:job_application).merge(job_apps)
        }
end
