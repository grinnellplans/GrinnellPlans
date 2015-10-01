require 'rails_helper'

describe SecretsController do
  setup :activate_authlogic

  describe 'GET index as an regular user' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account_session = AccountSession.create! @account
      @secret = Secret.create! secret_text: 'pssssst', display_attr: 'yes'
      Secret.create! secret_text: 'no', display_attr: 'no'
      get :index
    end
    subject { response }

    it 'should load secrets' do
      expect(assigns(:secrets)).to eq([@secret])
    end
    it { is_expected.to be_success }
    it { is_expected.to render_template('index') }
  end

  describe 'create a secret as a regular user' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account_session = AccountSession.create! @account
      @secret_text = "Shh.... it's a secret"
      post :create, secret: {secret_text: @secret_text}
    end

    subject { response }
    it { is_expected.to be_redirect }
    it 'should load secrets' do
      expect(assigns(:secret).secret_text).to eq @secret_text
    end
  end

  describe 'GET index when not logged in' do
    before do
      @account_session = nil
      get :index
    end
    subject { response }

    it 'should not load secrets' do
      expect(assigns(:secrets)).to eq(nil)
    end

    it { is_expected.to be_success }
    it { is_expected.to render_template('index') }
  end

  describe 'create a secret when not logged in' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account_session = AccountSession.create! @account
      @secret_text = "Shh.... it's a secret"
      post :create, secret: {secret_text: @secret_text}
    end

    subject { response }
    it { is_expected.to be_redirect }
    it 'should load secrets' do
      expect(assigns(:secret).secret_text).to eq @secret_text
    end
  end

  describe 'respects strong params on creation' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account_session = AccountSession.create! @account
      @secret_text = "Shh.... it's a secret"
      post :create, secret: {secret_text: @secret_text, display_attr: 'yes'}
    end

    subject { response }
    it { is_expected.to be_redirect }
    it 'should load secrets' do
      expect(assigns(:secret).display_attr).to eq 'no'
    end
  end

end
