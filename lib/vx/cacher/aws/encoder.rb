require 'securerandom'
module Vx
  module Cacher
    class Aws
      Encoder = Struct.new(:id, :string_size, :token_size) do

        def encode(mode)
          "#{token}#{mode}#{id}"
        end

        def token
          SecureRandom.urlsafe_base64(string_size, false)[0...string_size]
        end
      end
    end
  end
end
