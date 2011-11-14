Factory.define :plan do |p|
  p.add_attribute :plan,  8.times.collect{"blah "}.reduce(:+)
  p.add_attribute :edit_text,  8.times.collect{"blah "}.reduce(:+)
  def p.default_account
    @default_account ||= Factory(:account)
  end
  p.user_id { p.default_account.userid}
end