module Vx
  module Cacher
    class Aws
      Decoder = Struct.new(:encoded_string, :string_size, :token_size) do
        def decode
          body = encoded_string.to_s
          if body.size == token_size && %w{r w}.include?(body[string_size])
            token = body[0...string_size]
            mode  = body[string_size]
            id    = body[(string_size + 1)...token_size]
            [id, mode, token]
          end
        end
      end
    end
  end
end
