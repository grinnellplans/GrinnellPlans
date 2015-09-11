require 'rails_helper'

describe AccountSessionsController do
  describe 'new' do
    subject { get :new }
    it { expect(response).to be_success }
    it { is_expected.to render_template :new }
  end

  context 'with user' do
    before do
      Account.create!(username: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    end

    describe 'login' do
      before { post :create, account_session: { username: 'foobar', password: 'foobar' } }
      it { expect(response).to be_redirect }
    end

    describe 'failed login' do
      before do
        post :create, account_session: { username: 'foobar', password: 'barbaz' }
      end
      it { expect(response).to be_success }
      it { is_expected.to render_template :new }
    end
  end
end
