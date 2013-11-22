require 'spec_helper'

describe AccountSessionsController do
  describe 'new' do
    subject { get :new }
    it { response.should be_success }
    it { should render_template :new }
  end

  context 'with user' do
    before do
      Account.create!(username: 'foobar', password: 'foobar', password_confirmation: 'foobar')
    end

    describe 'login' do
      before { post :create, account_session: { username: 'foobar', password: 'foobar' } }
      it { response.should be_redirect }
    end

    describe 'failed login' do
      before do
        post :create, account_session: { username: 'foobar', password: 'barbaz' }
      end
      it { response.should be_success }
      it { should render_template :new }
    end
  end
end
