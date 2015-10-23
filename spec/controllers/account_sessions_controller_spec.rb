require 'rails_helper'

describe AccountSessionsController do
  describe 'new' do
    subject { get :new }
    it { expect(response).to be_success }
    it { is_expected.to render_template :new }
  end

  context 'with user' do
    before do
      @account = Account.create!(username: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    end

    describe 'login' do
      before { post :create, account_session: { username: 'foobar', password: 'foobar' } }
      it { expect(assigns[:session].record.id).to eq @account.id }
      it { expect(response).to redirect_to(root_path) }
    end

    describe 'failed login' do
      before do
        post :create, account_session: { username: 'foobar', password: 'barbaz' }
      end
      it { expect(assigns[:current_account]).to be_nil }
      it { expect(response).to be_success }
      it { is_expected.to render_template :new }
    end

    describe 'logout' do
      before do
        post :create, account_session: { username: 'foobar', password: 'foobar' }
        post :destroy
      end
      it { expect(response).to redirect_to(login_path) }
      it { expect(assigns[:current_account]).to be_nil }
      it { expect(assigns[:current_account_session]).to be_nil }
    end
  end
end
