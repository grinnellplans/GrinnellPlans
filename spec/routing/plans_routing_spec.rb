require 'rails_helper'

describe PlansController do
  describe 'routing' do

    it 'recognizes and generates #mark_level_as_read' do
      expect({ put: '/plans/mark_level_as_read' }).to route_to(controller: 'plans', action: 'mark_level_as_read')
    end

    it 'recognizes and generates #set_autofinger_level' do
      expect({ get: '/plans/set_autofinger_level' }).to route_to(controller: 'plans', action: 'set_autofinger_level')
    end

    it 'recognizes and generates #show' do
      expect({ get: '/plans/1' }).to route_to(controller: 'plans', action: 'show', id: '1')
    end
    #

  end
end
