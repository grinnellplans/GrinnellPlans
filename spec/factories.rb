FactoryGirl.define do
  factory :plan do |p|
    p.edit_text 8.times.map { 'blah ' }.reduce(:+)
    p.association :account
  end

  factory :account do |a|
    a.sequence(:username) { |i| "test#{i}" }
    a.password 'testpassword'
    a.password_confirmation 'testpassword'
    a.email 'test@test.com'
  end

  factory :autofinger do |a|
    a.association :interested_party, factory: :account
    a.association :subject_of_interest, factory: :account
    a.priority 1
    a.updated 1
  end

  factory :main_board do |b|
    b.title 'A notes thread'
    b.association :account
  end

  factory :sub_board do |b|
    contents "foo bar"
  end

  factory :board_vote do |v|
    v.association :account
    v.association :main_board
    v.association :sub_board
    v.vote_date Time.now
  end
end
