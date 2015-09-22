module Preferences
  class AvailLinksController < ApplicationController
    before_filter :require_user, :load_autofingers

    def show
      @available_links = AvailLink.active
      @current_links = current_account.avail_links.active
    end

    def update
      current_account.update unsafe_params[:account]
      redirect_to preferences_links_path
    end
  end
end
