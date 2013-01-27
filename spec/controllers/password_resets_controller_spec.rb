require 'spec_helper'

describe PasswordResetsController do
  describe "new" do
    subject { get :new }
    it { response.should be_success }
    it { should render_template :new }
  end

  context "with user" do
    before do
      @account = Account.create!( :username => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => 'foobar@bar.com' )
      ActionMailer::Base.deliveries.clear
    end

    describe "create" do
      before { post :create, :email => @account.email }
      it { response.should be_redirect }
      it "should send an email" do
        email = ActionMailer::Base.deliveries.first
        email.to[0].should == @account.email
        email.body.should =~ /#{@account.reload.perishable_token}/
      end
    end

    describe "failed create" do
      before { post :create, :password_reset => { :email => 'fred@example.com'} }
      it { response.should be_success }
      it { should render_template :new }
      it "should not have sent an email" do
        ActionMailer::Base.deliveries.first.should == nil
      end      
    end
  end
  
  context "with a reset token" do
    before do
      @account = Account.create!( :username => "foobar", :password => "foobar", :password_confirmation => "foobar", :email => 'foobar@bar.com' )
      @account.reset_perishable_token!
    end

    describe "edit" do
      before { get :edit, :id => @account.perishable_token }
      it { should render_template :edit }
      it { @controller.current_account.should == nil}
    end

    describe "update" do
      before do
        @password_was = @account.reload.crypted_password
        put :update, :id => @account.perishable_token, :account => {:password => 'newpassword', :password_confirmation => 'newpassword'} 
      end
      it { response.should be_redirect }
      it { @controller.current_account.should == @account}
      it "should have reset the password" do
        @password_was.should_not == @account.reload.crypted_password
      end
    end
  end

end
