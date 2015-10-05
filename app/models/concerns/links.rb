module Links
  extend ActiveSupport::Concern

  class PermanentLink
    attr_reader :linkname, :path_helper, :http_method
    def initialize opts
      @linkname = opts[:linkname]
      @path_helper = opts[:path_helper]
      @http_method = opts[:method] || :get
    end
  end

  # All the navigation links visible for this user
  def nav_links
    PREPEND_LINKS + avail_links.active + APPEND_LINKS
  end
  PREPEND_LINKS = [
      PermanentLink.new(linkname: "Edit Plan", path_helper: "edit_current_plan_path"),
      PermanentLink.new(linkname: "Search Plans", path_helper: "search_plans_path"),
      PermanentLink.new(linkname: "Preferences", path_helper: "root_path"),
  ]
  APPEND_LINKS = [
      PermanentLink.new(linkname: "Log Out", path_helper: "account_session_path", method: :delete),
  ]
end
