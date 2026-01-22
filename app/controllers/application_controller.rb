class ApplicationController < ActionController::Base
  include AuthorizationScope
  include ScopedFinder

  skip_forgery_protection

  before_action :authenticate_user!

end
