require "topological_inventory/amazon/logging"
require "topological_inventory/providers/common/operations/source"
require "topological_inventory/amazon/connection"

module TopologicalInventory
  module Amazon
    module Operations
      class Source < TopologicalInventory::Providers::Common::Operations::Source
        include Logging

        private

        def connection_check
          ec2_connection = TopologicalInventory::Amazon::Connection.ec2(
            :access_key_id     => authentication.username,
            :secret_access_key => authentication.password,
            :region            => region
          )

          ec2_connection.client.describe_regions.regions

          [STATUS_AVAILABLE, nil]
        rescue => e
          logger.availability_check("Failed to connect to Source id:#{source_id} - #{e.message}", :error)
          [STATUS_UNAVAILABLE, e.message]
        end

        def authentication
          @authentication ||= sources_api.fetch_authentication(source_id, endpoint, 'access_key_secret_key')
        end

        def region
          "us-east-1"
        end
      end
    end
  end
end
