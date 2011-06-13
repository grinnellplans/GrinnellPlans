require 'spec_helper'

describe "secrets/show.html.erb" do
  before(:each) do
    @secret = assign(:secret, stub_model(Secret))
  end

  it "renders attributes in <p>" do
    render
  end
end
