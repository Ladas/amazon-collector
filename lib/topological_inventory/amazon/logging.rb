require "topological_inventory/providers/common/logging"

module TopologicalInventory
  module Amazon
    class << self
      attr_writer :logger
    end

    def self.logger
      @logger ||= TopologicalInventory::Providers::Common::Logger.new
    end

    module Logging
      def logger
        TopologicalInventory::Amazon.logger
      end
    end
  end
end
