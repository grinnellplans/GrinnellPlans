module PhpCrypt
  module CryptoProviders
    class DES
      attr_writer :salt
      def self.salt
        @salt ||= 'ab'
      end

      def self.encrypt(* tokens)
        tokens.join.crypt salt
      end

      def self.matches?(crypted, *tokens)
        salt = crypted[ 0..1]
        begin
          crypted == tokens.join.crypt(salt)
        rescue Errno::EINVAL => e
          false
        end
      end
    end
  end
end
