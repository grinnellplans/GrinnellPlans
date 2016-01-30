module Preferences
  class DisplayController < ApplicationController
    before_filter :require_user, :load_autofingers

    def show
      populate
    end

    def update
      current_account.style = Style.find(params[:account][:display_preference][:style_id])
      if current_account.save
        redirect_to preferences_display_path
      else
        populate
        render "show"
      end
    end

    private
    def populate
      @user = current_account
      @available_styles = Style.all
    end
  end
end
