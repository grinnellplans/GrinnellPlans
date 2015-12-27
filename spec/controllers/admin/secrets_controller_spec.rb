require 'rails_helper'

describe Admin::SecretsController do
  setup :activate_authlogic

  describe 'GET index as an admin' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account.update_attribute(:is_admin, true)
      @account_session = AccountSession.create! @account
      @secrets = [
        Secret.create!(secret_text: 'approved secret', display: "yes"),
        Secret.create!(secret_text: 'rejected secret', display: "no", date_approved: Date.today),
        Secret.create!(secret_text: 'unmoderated secret', display: "no"),
      ]
    end

    it 'loads unmoderated secrets by default' do
      get :index
      expect(response).to render_template("index", locals: { resources: [@secrets[2]]})
    end

    it 'loads approved secrets when passed filter param' do
      get :index, filter: "accepted"
      expect(response).to render_template("index", locals: { resources: [@secrets[0]]})
    end

    it 'loads rejected secrets when passed filter param' do
      get :index, filter: "rejected"
      expect(response).to render_template("index", locals: { resources: [@secrets[1]]})
    end
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
      put :update, { id: @secret.id, secret: { display: 'yes' }, format: :js }
    end
    subject { response }

    it { is_expected.to be_success }
    it { expect(@secret.reload.display_attr).to eq 'yes' }
    it { expect(@secret.reload.date_approved).not_to be_nil }
  end

  describe 'deny as an admin' do
    before do
      @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
      @account.update_attribute(:is_admin, true)
      @account_session = AccountSession.create! @account
      @secret = Secret.create! secret_text: 'pssssst'
      put :update, { id: @secret.id, secret: { display: 'no' }, format: :js }
    end
    subject { response }

    it { expect(@secret.reload.display_attr).to eq 'no' }
    it { expect(@secret.reload.date_approved).not_to be_nil }
  end

end
