module Preferences
  class AccountDetailsController < ApplicationController
    before_filter :require_user, :load_autofingers

    def show
      populate
    end

    def update
      if current_account.update unsafe_params[:account]
        redirect_to preferences_account_path
      else
        populate
        render "show"
      end
    end

    private
    def populate
      @user = current_account
      @available_links = AvailLink.active
    end
  end
end
