require 'spec_helper'

describe "secrets/new.html.erb" do
  before(:each) do
    assign(:secret, stub_model(Secret).as_new_record)
  end

  it "renders new secret form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => secrets_path, :method => "post" do
    end
  end
end
