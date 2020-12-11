require 'topological_inventory/providers/common/metrics'

module TopologicalInventory
  module Amazon
    class Collector
      class Metrics < TopologicalInventory::Providers::Common::Metrics
        ERROR_TYPES = %i[general].freeze

        def initialize(port = 9394)
          super(port)

          init_counters
        end

        def init_counters
          ERROR_TYPES.each do |err_type|
            @error_counter&.observe(0, :type => err_type)
          end
        end

        def default_prefix
          "topological_inventory_amazon_collector_"
        end
      end
    end
  end
end
