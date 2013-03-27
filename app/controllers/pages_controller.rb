class PagesController < ApplicationController
  layout 'none'
  def index
  end

  def show
    @page = params.fetch(:id, 'index')
    expanded_page = "#{Rails.root}/app/views/pages/#{@page}.haml"
    exists = File.exists?(File.expand_path(expanded_page))
    if exists
      render :action => @page
    else
      render :text => "#{expanded_page} doesn't exist"
    end
  end
end