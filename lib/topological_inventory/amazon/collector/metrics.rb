require 'benchmark'
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

        def record_refresh_timing(labels = {}, &block)
          record_time(@refresh_timer, labels, &block)
        end

        private

        def configure_metrics
          super

          @refresh_timer = PrometheusExporter::Metric::Histogram.new('refresh_time', 'Duration of full refresh')
          @server.collector.register_metric(@refresh_timer)
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
