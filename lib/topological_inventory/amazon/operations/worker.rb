require "topological_inventory/amazon/logging"
require "topological_inventory/amazon/messaging_client"
require "topological_inventory/amazon/operations/processor"
require "topological_inventory/amazon/operations/source"
require "topological_inventory/providers/common/operations/health_check"

module TopologicalInventory
  module Amazon
    module Operations
      class Worker
        include Logging

        def run
          logger.info("Topological Inventory Amazon Operations worker started...")

          client.subscribe_topic(queue_opts) do |message|
            process_message(message)
          end
        rescue => err
          logger.error("#{err.cause}\n#{err.backtrace.join("\n")}")
        ensure
          client&.close
        end

        private

        def client
          @client ||= TopologicalInventory::Amazon::MessagingClient.default.worker_listener
        end

        def queue_opts
          TopologicalInventory::Amazon::MessagingClient.default.worker_listener_queue_opts
        end

        def process_message(message)
          Processor.process!(message)
        rescue => e
          logger.error("#{e}\n#{e.backtrace.join("\n")}")
          raise
        ensure
          message.ack
          TopologicalInventory::Providers::Common::Operations::HealthCheck.touch_file
        end
      end
    end
  end
end
