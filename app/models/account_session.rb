class AccountSession < Authlogic::Session::Base
  # Workaround for Rails 3 compat
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
end
