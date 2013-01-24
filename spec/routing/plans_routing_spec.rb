require "spec_helper"

describe PlansController do
  describe "routing" do

    it "recognizes and generates #mark_level_as_read" do
      { :put => "/plans/mark_level_as_read" }.should route_to(:controller => "plans", :action => "mark_level_as_read")
    end

    it "recognizes and generates #set_autofinger_level" do
      { :get => "/plans/set_autofinger_level" }.should route_to(:controller => "plans", :action => "set_autofinger_level")
    end

    it "recognizes and generates #show" do
      { :get => "/plans/1" }.should route_to(:controller => "plans", :action => "show", :id => "1")
    end
    # 

  end
end
