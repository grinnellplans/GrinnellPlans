require 'spec_helper'

describe 'secrets/new.html.haml' do
  before(:each) do
    assign(:secret, stub_model(Secret).as_new_record)
  end
pending do
  it 'renders new secret form' do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'form', action: secrets_path, method: 'post' do
    end
  end
end
end
