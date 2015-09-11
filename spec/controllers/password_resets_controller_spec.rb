require 'rails_helper'

describe PasswordResetsController do
  describe 'new' do
    subject { get :new }
    it { expect(response).to be_success }
    it { is_expected.to render_template :new }
  end

  context 'with user' do
    before do
      @account = Account.create!(username: 'foobar', password: 'foobar', password_confirmation: 'foobar', email: 'foobar@bar.com')
      ActionMailer::Base.deliveries.clear
    end

    describe 'create' do
      before { post :create, email: @account.email }
      it { expect(response).to be_redirect }
      it 'should send an email' do
        email = ActionMailer::Base.deliveries.first
        expect(email.to[0]).to eq @account.email
        expect(email.body).to match(/#{@account.reload.perishable_token}/)
      end
    end

    describe 'failed create' do
      before { post :create, password_reset: { email: 'fred@example.com' } }
      it { expect(response).to be_success }
      it { is_expected.to render_template :new }
      it 'should not have sent an email' do
        expect(ActionMailer::Base.deliveries.first).to eq nil
      end
    end
  end

  context 'with a reset token' do
    before do
      @account = Account.create!(username: 'foobar', password: 'foobar', password_confirmation: 'foobar', email: 'foobar@bar.com')
      @account.reset_perishable_token!
    end

    describe 'edit' do
      before { get :edit, id: @account.perishable_token }
      it { is_expected.to render_template :edit }
      it { expect(@controller.current_account).to eq nil }
    end

    describe 'update' do
      before do
        @password_was = @account.reload.crypted_password
        put :update, id: @account.perishable_token, account: { password: 'newpassword', password_confirmation: 'newpassword' }
      end
      it { expect(response).to be_redirect }
      it { expect(@controller.current_account).to eq @account }
      it 'should have reset the password' do
        expect(@password_was).not_to eq(@account.reload.crypted_password)
      end
    end
  end

end
