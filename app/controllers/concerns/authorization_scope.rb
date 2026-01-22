module AuthorizationScope
  extend ActiveSupport::Concern

  included do
    helper_method :job_application_scope
  end 

  private

  def job_application_scope
    return JobApplication.all if current_user.admin? 
    current_user.job_applications
  end 
end 
