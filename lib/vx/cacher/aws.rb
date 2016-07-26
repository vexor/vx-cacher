require 'aws-sdk'
require 'net/http'

module Vx
  module Cacher
    Aws = Struct.new(:container_name, :logger) do
      autoload :Encoder, File.expand_path("../aws/encoder", __FILE__)
      autoload :Decoder, File.expand_path("../aws/decoder", __FILE__)

      SIZE        = 64
      TOKEN_SIZE  = 64 + 1 + 36
      PERMISSIONS_MAP = {
        "r" => :get,
        "w" => :put
      }

      def encoder(id)
        Aws::Encoder.new(id, SIZE, TOKEN_SIZE)
      end

      def decode(encoded_string)
        Aws::Decoder.new(encoded_string, SIZE, TOKEN_SIZE).decode
      end

      def generate_url(uri, permission = 'r')
        bucket_object(uri).presigned_url(PERMISSIONS_MAP[permission], expires_in: 15.minutes)
      end

      def all(project_id)
        list_blobs(project_id).map do |blob|
          Blob.new(
            blob.key.gsub(/#{project_id}\//, ''),
            blob.size,
            blob.last_modified,
            nil
          )
        end
      end

      def destroy(project_id, files)
        keys = files.map{ |i| {key: "#{project_id}/#{i}"} }
        begin
          bucket.delete_objects(delete: { objects: keys })
        rescue => e
          Rails.logger.warn "#{self.class} - #{e.class} - #{e.message}"
        end
      end

      # private

      def list_blobs(prefix)
        bucket.objects(prefix: prefix)
      end

      def client
        @client ||= ::Aws::S3::Client.new(region: ENV['AWS_REGION'], credentials: credentials)
      end

      def resource
        @resource ||= ::Aws::S3::Resource.new(client: client)
      end

      def credentials
        @credentials ||= ::Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
      end

      def bucket_object(name)
        bucket.object(name)
      end

      def bucket
        @bucket ||= resource.bucket(ENV["AWS_CACHE_BUCKET"])
      end
    end
  end
end
