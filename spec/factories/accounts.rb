Factory.define :account do |a|
  a.sequence(:username) {|i| "test#{i}" }
  a.password "testpassword"
  a.password_confirmation "testpassword"
  a.email "test@test.com"
end
