# lib/bellmyer/create_alias.rb
module Bellmyer
  module CreateAlias
    def self.included(base)
      base.extend CreateAliasMethods
    end

    module CreateAliasMethods
      def create_alias old_name, new_name
        define_method new_name.to_s do
          self.read_attribute old_name.to_s
        end

        define_method new_name.to_s + "=" do |value|
          self.write_attribute old_name.to_s, value
        end
      end
    end
  end
end
