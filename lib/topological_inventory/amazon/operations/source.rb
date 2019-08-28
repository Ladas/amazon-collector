require "sources-api-client"
require "active_support/core_ext/numeric/time"
require "topological_inventory/amazon/connection"
require "topological_inventory/amazon/operations/core/authentication_retriever"

module TopologicalInventory
  module Amazon
    module Operations
      class Source
        include Logging
        STATUS_AVAILABLE, STATUS_UNAVAILABLE = %w[available unavailable].freeze

        attr_accessor :params, :context, :source_id

        def initialize(params = {}, request_context = nil)
          @params  = params
          @context = request_context
          @source_id = nil
        end

        def availability_check
          source_id = params["source_id"]
          unless source_id
            logger.error("Missing source_id for the availability_check request")
            return
          end

          source = SourcesApiClient::Source.new
          source.availability_status = connection_check(source_id)

          begin
            api_client.update_source(source_id, source)
          rescue SourcesApiClient::ApiError => e
            logger.error("Failed to update Source id:#{source_id} - #{e.message}")
          end
        end

        private

        def connection_check(source_id)
          endpoints = api_client.list_source_endpoints(source_id)&.data || []
          endpoint = endpoints.find(&:default)
          return STATUS_UNAVAILABLE unless endpoint

          endpoint_authentications = api_client.list_endpoint_authentications(endpoint.id.to_s).data || []
          return STATUS_UNAVAILABLE if endpoint_authentications.empty?

          auth_id = endpoint_authentications.first.id
          auth = Core::AuthenticationRetriever.new(auth_id, identity).process
          return STATUS_UNAVAILABLE unless auth

          ec2_connection = TopologicalInventory::Amazon::Connection.ec2(
            :access_key_id     => auth.username,
            :secret_access_key => auth.password,
            :region            => region
          )

          ec2_connection.client.describe_regions.regions

          STATUS_AVAILABLE
        rescue => e
          logger.error("Failed to connect to Source id:#{source_id} - #{e.message}")
          STATUS_UNAVAILABLE
        end

        def identity
          @identity ||= { "x-rh-identity" => Base64.strict_encode64({ "identity" => { "account_number" => params["external_tenant"] }}.to_json) }
        end

        def api_client
          @api_client ||= begin
            api_client = SourcesApiClient::ApiClient.new
            api_client.default_headers.merge!(identity)
            SourcesApiClient::DefaultApi.new(api_client)
          end
        end

        def region
          "us-east-1"
        end
      end
    end
  end
end
