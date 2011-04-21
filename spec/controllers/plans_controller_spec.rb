require 'spec_helper'

describe PlansController do
  setup :activate_authlogic
  before do
    @account = Account.create! :username => "testaccount", :password => "123456", :password_confirmation => "123456"
    @plan = Plan.create! :account => @account, :edit_text => ""
    @account_session = AccountSession.create! @account
  end

  it "redirects to login when no user present" do
    @account_session.destroy
    get :show, :id => @account.username
    assert_redirected_to new_account_session_path
  end

  describe "read plan" do
    before { get :show, :id => @account.username }
    subject { response }
    it { should be_success }
    it { should render_template( "show" ) }
    it { assigns( :plan ).should == @plan }
  end

  describe "update plan" do
    it "does not allow updates of generated html"
  end
end
