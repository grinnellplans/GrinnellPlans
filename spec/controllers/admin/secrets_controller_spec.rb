require 'rails_helper'

describe Admin::SecretsController do
  setup :activate_authlogic

  describe 'GET index as an admin' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account.update_attribute(:is_admin, true)
      @account_session = AccountSession.create! @account
      @secret = Secret.create! secret_text: 'pssssst'
      get :index
    end
    subject { response }

    it 'should load secrets' do
      expect(assigns(:secrets)).to eq([@secret])
    end
    it { is_expected.to be_success }
    it { is_expected.to render_template('index') }
  end

  describe 'GET index as an regular user' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account_session = AccountSession.create! @account
      get :index
    end
    subject { response }

    it { is_expected.to be_redirect }
  end

  describe 'GET index when not logged in' do
    before do
      @account_session = nil
      get :index
    end
    subject { response }

    it { is_expected.to be_redirect }
  end

  describe 'approve as an admin' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account.update_attribute(:is_admin, true)
      @account_session = AccountSession.create! @account
      @secret = Secret.create! secret_text: 'pssssst'
      put :update, id: @secret.id, display_attr: 'yes'
    end

    it { expect(assigns(:secret).display_attr).to eq 'yes' }
    it { expect(assigns(:secret).date_approved).not_to be_nil }
  end

  describe 'deny as an admin' do
   before do
     @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
     @account.update_attribute(:is_admin, true)
     @account_session = AccountSession.create! @account
     @secret = Secret.create! secret_text: 'pssssst'
     put :update, id: @secret.id, display_attr: 'no'
   end

   it { expect(assigns(:secret).display_attr).to eq 'no' }
   it { expect(assigns(:secret).date_approved).not_to be_nil }
 end

end
