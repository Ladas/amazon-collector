require 'topological_inventory/providers/common/metrics'

module TopologicalInventory
  module Amazon
    class Collector
      class Metrics < TopologicalInventory::Providers::Common::Metrics
        ERROR_TYPES = %i[general].freeze

        def initialize(port = 9394)
          super(port)
        end

        def default_prefix
          "topological_inventory_amazon_collector_"
        end
      end
    end
  end
end
