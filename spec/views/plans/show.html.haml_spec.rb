require "spec_helper"

describe "plans/show.html.haml" do
  it "displays plan html" do
    plan = mock
    plan.expects( :plan ).returns( "Foo <b>bar</b>" )
    assign :plan, plan
    render
    rendered.should == "Foo <b>bar</b>\n"
  end
end
