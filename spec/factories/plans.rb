Factory.define :plan do |p|
  p.edit_text 8.times.collect{"blah "}.reduce(:+)
  p.association :account
end
