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
end
