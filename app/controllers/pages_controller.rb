class PagesController < ApplicationController
  layout 'minimal'
  def index
  end

  def show
    @page = unsafe_params.fetch(:id, 'index')
    expanded_page = "#{Rails.root}/app/views/pages/#{@page}.haml"
    exists = File.exist?(File.expand_path(expanded_page))
    if exists
      render action: @page
    else
      render text: "#{expanded_page} doesn't exist"
    end
  end
end
