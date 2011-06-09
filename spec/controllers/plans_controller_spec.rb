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
        assert_redirected_to read_path( :id => @account.username )
      end
    end
    it "does not allow updates of generated html" do
      Plan.any_instance.expects( :generated_html= ).with( regexp_matches /.*Foo.*/ ).at_least_once
      Plan.any_instance.expects( :generated_html= ).with( "Something evil" ).never
      post :update, :id => @account.username, :plan => { :edit_text => "Foo bar", :generated_html => "Something evil" }
    end
  end
end
