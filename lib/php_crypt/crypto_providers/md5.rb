module PhpCrypt
  module CryptoProviders
    class MD5
      def self.encrypt(* tokens)
        Crypt3.crypt tokens.join
      end

      def self.matches?(crypted, *tokens)
        begin
          Crypt3.check tokens.join, crypted
        rescue
          false
        end
      end
    end
  end
end
