require 'spec_helper'

describe 'plans/show.html.haml' do
  skip 'displays plan html' do
    account = stub_model(Account)
    expect(account.plan).to receive(:generated_html).and_return('Foo <b>bar</b>'.html_safe)
    assign :account, account
    render
    # TODO
    # rendered.should be_same_html_as "Foo <b>bar</b>"
  end
end
