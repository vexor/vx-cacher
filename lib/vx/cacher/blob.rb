module Vx
  module Cacher
    Blob = Struct.new(:name, :size, :updated_at, :contant_type) do
      def as_json(*args)
        {
          id:   name,
          name: name,
          size_in_bytes: size,
          size: number_to_human_size(size),
          updated_at: updated_at,
          contant_type: contant_type
        }
      end

      private

      # TODO: Refactor
      def number_to_human_size(size)
        size
      end
    end
  end
end
