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
    assert_redirected_to '/login'
  end

  describe "read plan" do
    before { get :show, :id => @account.username }
    subject { response }
    it { should be_success }
    it { should render_template( "show" ) }
    it { assigns( :account ).should == @account }
  end
  

  describe "update plan" do
    context "normal request" do
      before do
        post :update, :id => @account.username, :plan => { :edit_text => "Foo bar" }
      end
      it "changes plan contents" do
        @plan.reload.edit_text.should == "Foo bar"
      end
      it "updates changed timestamp" do
        @account.reload.changed_date.should >= Time.now - 5
      end
      it "redirects to show" do
        assert_redirected_to read_plan_path( :id => @account.username )
      end
    end
  end
  describe "edit plan"
  describe "search plan"
  describe "set_autofinger_level"
  describe "mark_level_as_read"
end
