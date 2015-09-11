require 'rails_helper'

shared_examples_for 'password oracle' do
  it 'validates correct password' do
    expect(subject.valid_password?('foobar')).to be_truthy
  end
  it 'does not validate incorrect password' do
    expect(subject.valid_password?('barbaz')).to be_falsey
  end
end

describe Account do

  context 'with password' do
    subject do described_class.create(username: 'foobar', password: 'foobar', password_confirmation: 'foobar')
     described_class.last
    end

    describe '#crypted_password' do
      subject { super().crypted_password }
      it { is_expected.to be_present }
    end

    describe '#password_salt' do
      subject { super().password_salt }
      it { is_expected.to be_present }
    end

    describe '#crypted_password' do
      subject { super().crypted_password }
      it { is_expected.not_to eq('foobar') }
    end

    describe '#password' do
      subject { super().password }
      it { is_expected.not_to eq('foobar') }
    end
    it_behaves_like 'password oracle'
  end

  it 'fails if password confirmation is mismatch' do
    expect(described_class.create(username: 'foobar', password: 'foobar', password_confirmation: 'barbaz')).to be_invalid
  end

  it 'fails if password confirmation is missing' do
    expect(described_class.create(username: 'foobar', password: 'foobar')).to be_invalid
  end

  context 'legacy MD5 password' do
    subject { described_class.create username: 'foobar', crypted_password: '$1$f8Qwor9I$bSkUziPv/xNI/.Vhb/NUr.' }
    it_behaves_like 'password oracle'
  end

  context 'legacy DES password' do
    subject { described_class.create username: 'foobar', crypted_password: 'abVbJXzHUY99s' }
    it_behaves_like 'password oracle'
    it 'transitions password on successful validation' do
      subject.valid_password?('foobar')
      expect(subject.crypted_password).to match(/\$1\$.{8}\$.{22}/)
    end
  end

  describe '#create_random_token' do
    it 'creates 8 character random token' do
      token = Account.create_random_token
      assert_equal 8, token.size
    end
  end

  describe '#create_from_tentative' do
    it 'creates new account' do
      username = 'bob'
      email = 'bob@blop.blop'
      ta = TentativeAccount.create(username: username, user_type: 'student', email: email, confirmation_token: 'ABCD')
      password = SecureRandom.hex(10)
      account = Account.create_from_tentative ta, password
      expect(account).not_to be_nil

      # an account should have been created
      account = Account.find_by_username username
      assert_equal email, account.email

      # a plan should have been created
      plan = Plan.find_by_user_id account.userid
      assert_equal '', plan.plan

      # tentative account should have been deleted
      ta = TentativeAccount.find_by_username username
      assert_equal nil, ta
    end
  end

end

# == Schema Information
#
# Table name: accounts
#
#  userid            :integer         not null, primary key
#  username          :string(16)      default(""), not null
#  created           :datetime
#  password          :string(34)
#  email             :string(64)
#  pseudo            :string(64)
#  login             :datetime
#  changed           :datetime
#  poll              :integer(1)
#  group_bit         :string(1)
#  spec_message      :string(255)
#  grad_year         :string(4)
#  edit_cols         :integer(1)
#  edit_rows         :integer(1)
#  webview           :string(1)       default("0")
#  notes_asc         :string(1)
#  user_type         :string(128)
#  show_images       :boolean         default(FALSE), not null
#  guest_password    :string(30)
#  is_admin          :boolean         default(FALSE)
#  persistence_token :string(255)
#  password_salt     :string(255)
#  perishable_token  :string(255)     default(""), not null
#
