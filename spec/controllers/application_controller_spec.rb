require 'spec_helper'

describe ApplicationController do
  # This sets up an anonymous controller to let us easily test the
  # logic in ApplicationController.
  controller do
    before_filter :load_autofingers
    def index
      render :nothing => true
    end
  end

  describe "autofinger" do
    before do
      @interest = Factory.create :autofinger, :updated => 1
      controller.stub(:current_account) { @interest.interested_party }
    end
    it "is populated" do
      get :index, {}, {:autofinger_level => @interest.priority}
      assigns( :autofingers ).should == [@interest]
    end
  end
end
