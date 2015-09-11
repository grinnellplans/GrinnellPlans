require 'rails_helper'

describe SecretsController do
  describe 'routing' do

    it 'recognizes and generates #index' do
      expect({ get: '/secrets' }).to route_to(controller: 'secrets', action: 'index')
    end

    it 'recognizes and generates #new' do
      expect({ get: '/secrets/new' }).to route_to(controller: 'secrets', action: 'new')
    end

    it 'recognizes and generates #show' do
      expect({ get: '/secrets/1' }).to route_to(controller: 'secrets', action: 'show', id: '1')
    end
    #
    # it "recognizes and generates #edit" do
    #   { :get => "/secrets/1/edit" }.should route_to(:controller => "secrets", :action => "edit", :id => "1")
    # end

    it 'recognizes and generates #create' do
      expect({ post: '/secrets' }).to route_to(controller: 'secrets', action: 'create')
    end

    it 'recognizes and generates #update' do
      expect({ put: '/secrets/1' }).to route_to(controller: 'secrets', action: 'update', id: '1')
    end

    it 'recognizes and generates #destroy' do
      expect({ delete: '/secrets/1' }).to route_to(controller: 'secrets', action: 'destroy', id: '1')
    end

  end
end
