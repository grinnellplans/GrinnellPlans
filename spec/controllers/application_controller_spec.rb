require 'rails_helper'

describe ApplicationController do
  # This sets up an anonymous controller to let us easily test the
  # logic in ApplicationController.
  controller do
    def index
      render nothing: true
    end
  end

  describe 'autofinger' do
    before do
      @interest = FactoryGirl.create :autofinger, updated: 1, priority: 2
      allow(controller).to receive(:current_account) { @interest.interested_party }
    end
    it 'is populated' do
      expect(controller.autofingers).to eq({
        1 => [],
        2 => [@interest],
        3 => [],
      })
    end
  end
end
