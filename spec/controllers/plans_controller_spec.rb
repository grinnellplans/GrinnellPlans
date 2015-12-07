require 'rails_helper'

describe PlansController do
  setup :activate_authlogic
  before do
    @account = Account.create! username: 'testaccount', password: '123456', password_confirmation: '123456'
    @plan = Plan.create! account: @account, edit_text: ''
    @account_session = AccountSession.create! @account
  end

  it 'redirects to login when no user present' do
    @account_session.destroy
    get :show, id: @account.username
    assert_redirected_to login_path
  end

  describe 'read plan' do
    before { get :show, id: @account.username }
    subject { response }
    it { is_expected.to be_success }
    it { is_expected.to render_template('show') }
    it { expect(assigns(:account)).to eq @account }
  end

  describe 'update plan' do
    context 'normal request' do
      before do
        post :update, id: @account.username, plan: { edit_text: 'Foo bar' }
      end
      it 'changes plan contents' do
        expect(@plan.reload.edit_text).to eq 'Foo bar'
      end
      it 'updates changed timestamp' do
        expect(@account.reload.changed_date).to be >= Time.now - 5
      end
      it 'redirects to show' do
        assert_redirected_to read_plan_path(id: @account.username)
      end
    end

    it 'updates autofinger entries' do
      follower = Account.create! username: 'follower', password: '123456', password_confirmation: '123456'
      follow_relationship = follower.interests_in_others.create!(subject_of_interest: @account, priority: 1, updated: 0)
      expect {
        post :update, id: @account.username, plan: { edit_text: 'Foo bar baz' }
      }.to change { follow_relationship.reload.updated }.from('0').to('1')
    end
  end

  describe 'mark_level_as_read' do
    context 'normal request' do
      before do
        interest = Account.create! username: 'acctinterest', password: '123456', password_confirmation: '123456'
        interest2 = Account.create! username: 'acctinterest2', password: '123456', password_confirmation: '123456'
        @account.interests_in_others.create!(interest: interest.id, priority: 1, updated: 1)
        @account.interests_in_others.create!(interest: interest2.id, priority: 2, updated: 1)

        # sanity
        assert_equal 1, @account.interests_in_others.updated.where(priority: 1).count
        assert_equal 1, @account.interests_in_others.updated.where(priority: 2).count

        put :mark_level_as_read, level: '1', return_to: '/'
      end

      it 'should mark all as read for priority one' do
        assert_equal 0, @account.interests_in_others.updated.where(priority: 1).count
      end
      it 'should not mark all as read for priority two' do
        assert_equal 1, @account.interests_in_others.updated.where(priority: 2).count
      end
      it 'redirects to root' do
        assert_redirected_to '/'
      end
    end
  end

  describe 'set_autofinger_subscription' do
    let(:interest) { FactoryGirl.create :account }

    context 'logged in user adds new plan to autoread list' do
      before do
        @request.env['HTTP_REFERER'] = "/plans/#{interest.username}" #so redirect_to :back doesn't break
        post :set_autofinger_subscription, id: interest.username, priority: 1
      end

      it 'sets correct autoread priority' do
        expect(@account.interests_in_others.find_by_interest(interest.id).priority).to eq 1
      end
      it 'sets correct flash message' do
        expect(flash[:notice]).to eq 'User is now on your autoread list with priority level of 1.'
      end
    end

    context 'logged in user changes priority of existing autoread subject' do
      before do
        @request.env['HTTP_REFERER'] = "/plans/#{interest.username}" #so redirect_to :back doesn't break
        Autofinger.create(owner: @account.id, interest: interest.id, priority: 2)
        post :set_autofinger_subscription, id: interest.username, priority: new_priority
      end

      context 'changes to different priority' do
        let(:new_priority) { 3 }
        it 'sets correct autoread priority' do
          expect(@account.interests_in_others.find_by_interest(interest.id).priority).to eq 3
        end
        it "doesn't create an extra Autofinger instance" do
          expect(Autofinger.where("interest = ? AND owner = ?", interest.id, @account.id).count).to eq 1
        end
        it 'sets correct flash message' do
          expect(flash[:notice]).to eq 'User is now on your autoread list with priority level of 3.'
        end
      end

      context 'removes plan from autoread list' do
        let(:new_priority) { 0 }
        it 'sets correct autoread priority' do
          expect(@account.interests_in_others.find_by_interest(interest.id).priority).to eq 0
        end
        it "doesn't create an extra Autofinger instance" do
          expect(Autofinger.where("interest = ? AND owner = ?", interest.id, @account.id).count).to eq 1
        end
        it 'sets correct flash message' do
          expect(flash[:notice]).to eq 'User was removed from your autoread list.'
        end
      end

      context 'assigns an invalid priority' do
        let(:new_priority) { 4 }
        it "doesn't change autoread priority" do
          expect(@account.interests_in_others.find_by_interest(interest.id).priority).to eq 2
        end
        it 'sets correct flash message' do
          expect(flash[:notice]).to eq 'Could not change autoread priority. If this happens more than once, contact the Plans admins at grinnellplans@gmail.com.'
        end
      end
    end
  end

  describe 'edit plan'

  describe 'search plan' do
    context 'given the username of an existing plan' do
      let(:plan) { FactoryGirl.create :plan }
      let!(:username) { plan.account.username }
      it 'redirects to that plan' do
        get :search, id: username
        expect(response).to redirect_to(read_plan_path(username))
      end
    end

    context 'given any other input' do
      #TODO
    end
  end

  describe 'set_autofinger_level'

end
