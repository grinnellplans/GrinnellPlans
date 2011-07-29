require "spec_helper"

describe "plans/show.html.haml" do
  it "displays plan html" do
    plan = mock
    plan.should_receive(:generated_html ).and_return( "Foo <b>bar</b>".html_safe )
    assign :plan, plan
    render
    rendered.should be_same_html_as "Foo <b>bar</b>"
  end
end
