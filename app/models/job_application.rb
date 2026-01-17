# == Schema Information
#
# Table name: job_applications
#
#  id               :bigint           not null, primary key
#  applied_on       :date
#  company_name     :string
#  due_date         :date
#  interviews_count :integer
#  role             :string
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#
class JobApplication < ApplicationRecord
end
