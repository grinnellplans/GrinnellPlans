require 'spec_helper'

describe SecretsController do
  describe 'routing' do

    it 'recognizes and generates #index' do
      { get: '/secrets' }.should route_to(controller: 'secrets', action: 'index')
    end

    it 'recognizes and generates #new' do
      { get: '/secrets/new' }.should route_to(controller: 'secrets', action: 'new')
    end

    it 'recognizes and generates #show' do
      { get: '/secrets/1' }.should route_to(controller: 'secrets', action: 'show', id: '1')
    end
    #
    # it "recognizes and generates #edit" do
    #   { :get => "/secrets/1/edit" }.should route_to(:controller => "secrets", :action => "edit", :id => "1")
    # end

    it 'recognizes and generates #create' do
      { post: '/secrets' }.should route_to(controller: 'secrets', action: 'create')
    end

    it 'recognizes and generates #update' do
      { put: '/secrets/1' }.should route_to(controller: 'secrets', action: 'update', id: '1')
    end

    it 'recognizes and generates #destroy' do
      { delete: '/secrets/1' }.should route_to(controller: 'secrets', action: 'destroy', id: '1')
    end

  end
end
