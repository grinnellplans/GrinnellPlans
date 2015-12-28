require 'rails_helper'

RSpec.describe Preferences::AccountDetailsController, type: :controller do
  setup :activate_authlogic
  before do
    @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
    @plan = Plan.create! account: @account, edit_text: ''
    @account_session = AccountSession.create! @account
  end

  before do
    @avail_links = [
      FactoryGirl.create(:avail_link),
      FactoryGirl.create(:avail_link),
      FactoryGirl.create(:avail_link),
    ]

    FactoryGirl.create :opt_link, account: @account, avail_link: @avail_links[0]
    FactoryGirl.create :opt_link, account: @account, avail_link: @avail_links[2]
  end

  describe '#show' do
    before { get :show }
    subject { response }
    it { is_expected.to be_success }
    it { is_expected.to render_template('show') }
    it { expect(assigns(:available_links)).to eq(@avail_links) }
    it { expect(assigns(:current_links)).to eq([@avail_links[0], @avail_links[2]]) }
  end

  describe '#update' do
    before do
      put :update, account: { avail_link_ids: [@avail_links[0].id, @avail_links[1].id] }
    end
    subject { response }
    it { is_expected.to redirect_to(preferences_account_path) }
    it "updates user's links" do
      expect(@account.reload.avail_links).to eq([@avail_links[0], @avail_links[1]])
    end
  end
end
