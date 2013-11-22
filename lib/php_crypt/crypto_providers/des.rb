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
        crypted == tokens.join.crypt(salt)
      end
    end
  end
end
