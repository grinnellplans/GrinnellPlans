class ApplicationController < ActionController::Base
  protect_from_forgery


# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
helper :all # include all helpers, all the time

end
