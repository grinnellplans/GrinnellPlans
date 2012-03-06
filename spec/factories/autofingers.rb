Factory.define :autofinger do |a|
  a.association :interested_party, :factory => :account
  a.association :subject_of_interest, :factory => :account
  a.priority 1
  a.updated 1
end
